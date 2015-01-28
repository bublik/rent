class RentersController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  before_action :set_renter, only: [:show, :edit, :update, :destroy, :publish]
  before_action :create_order, only: [:show]

  # GET /renters
  # GET /renters.json
  def index
    @renters = Renter.order(sort_column + " " + sort_direction)

    if user_signed_in?
      @renters = current_user.renters.order(sort_column + " " + sort_direction) if current_user.is_manager?
      if current_user.has_role?(:realtor) || current_user.has_role?(:vip_realtor)
        @renters = params[:with_order].eql?('true') ? @renters.with_order(current_user) : @renters.published
        #   @renters = @renters.hide_inactive
      end
      if params[:state].present?
        @renters = @renters.by_state(params[:state])
      end
    else
      @renters = @renters.published.limit(100)
    end

    if params[:check_in].present?
      @renters = @renters.check_in_from(Date.parse(params[:check_in]))
    end

    @renters = @renters.where(town_id: params[:town_id] || 2)
    @renters = @renters.page(params[:page]).per(10)
    @url = params.dup
    @url.delete(:town_id)
    @url[:page] = params[:page] || 0
  end

  # GET /renters/1
  # GET /renters/1.json
  def show
    if user_signed_in?
      access = Access.where(renter_id: params[:id], user_id: current_user.id).first ||
        Access.create(renter_id: params[:id], user_id: current_user.id)

      access.increment!(:counter)

      @accesses = Access.where(renter_id: @renter.id).joins(:user)
      @order_user_ids = @renter.orders.pluck(:user_id)
    end

  end

  def grant_access
    state = if (order = Order.where(user_id: params[:user_id], renter_id: params[:id]).first) && order.destroy
      'removed'
    else
      'created' if order = Order.create!(user_id: params[:user_id], renter_id: params[:id], skip_payment: true)
    end

    respond_to do |format|
      format.js {
        case state
          when 'created'
            # TODO refactor this code (duplicated with model)
            Notifications.access_to_renter(order.user, order.renter).deliver
            render text: "$('.realtors #user_#{params[:user_id]} .btn').addClass('btn-success');"
          when 'removed'
            render text: "$('.realtors #user_#{params[:user_id]} .btn').removeClass('btn-success');"
        end
      }
    end
  end

  # GET /renters/new
  def new
    @renter = Renter.new
  end

  # GET /renters/1/edit
  def edit
  end

  # POST /renters
  # POST /renters.json
  def create
    @renter = Renter.new(renter_params)
    @renter.user = current_user

    respond_to do |format|
      if @renter.save
        format.html {
          if current_user.has_role?(:realtor) || current_user.has_role?(:vip_realtor)
            redirect_to root_path, notice: 'Заявка отправлена'
          else
            redirect_to @renter, notice: 'Запись успешно добавлена.'
          end
        }
        format.json { render action: 'show', status: :created, location: @renter }
      else
        format.html { render action: 'new' }
        format.json { render json: @renter.errors, status: :unprocessable_entity }
      end
    end
  end

  def notify
    Renter.inform_new_paid_renters
    render text: 'OK'
  end

  def publish
    @renter.publish
    @renter.published_at = Time.now + params[:time].to_i.hours
    @renter.save

    notice = "Запись будет опубликована #{l(@renter.published_at, format: :short)}."

    respond_to do |format|
      format.html { redirect_to @renter, notice: notice }
      format.js { flash.now[:notice] = notice }
    end
  end

  # PATCH/PUT /renters/1
  # PATCH/PUT /renters/1.json
  def update
    respond_to do |format|
      if @renter.update(renter_params)
        format.html { redirect_to @renter, notice: 'Запись успешно обновлена.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @renter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /renters/1
  # DELETE /renters/1.json
  def destroy
    @renter.destroy
    respond_to do |format|
      format.html { redirect_to renters_url }
      format.json { head :no_content }
    end
  end

  def check_duplicate
    phone = params['phone'].sub!(/^\s/, '+')
    renter = Renter.where(phone: phone).last
    if renter
      flash[:notice] = "Последняя запись с таким телефоном была добавлена #{l(renter.created_at, format: :short)}"
    end
  end

  private
  def sort_column
    Renter.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_renter
    @renter = Renter.find(params[:id])
    @renter = current_user.renters.find_by_id(params[:id]) if user_signed_in? && current_user.is_manager?
  end

  def create_order
    @renter.create_order(current_user) if user_signed_in? && (current_user.has_role?(:realtor) || current_user.has_role?(:vip_realtor))
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def renter_params
    params.require(:renter).permit(:phone, :email, :phone_format, :guard_time, :town_id, :max_sales, :rooms, :people, :amount_from, :amount_to, :check_in, :check_out, :description, :agent)
  end
end
