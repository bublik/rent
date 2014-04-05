class RentersController < ApplicationController
  before_filter :authenticate_user!, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  before_action :set_renter, only: [:show, :edit, :update, :destroy]
  before_action :create_order, only: [:show]

  # GET /renters
  # GET /renters.json
  def index
    @renters = Renter.order(sort_column + " " + sort_direction)

    if user_signed_in?
      @renters = current_user.renters.order(sort_column + " " + sort_direction) if current_user.has_role?(:manager)
      @renters = @renters.hide_inactive if current_user.has_role?(:realtor) || current_user.has_role?(:vip_realtor)
      @renters = @renters.with_order(current_user) if params[:with_order].eql?('true')
    else
      @renters = @renters.last24h.hide_inactive
    end
    if params[:check_in].present?
      @renters = @renters.check_in_from(Date.parse(params[:check_in]))
    end
    @renters = @renters.page(params[:page]).per(10)
  end

  # GET /renters/1
  # GET /renters/1.json
  def show
  end

  def grant_access
    if (order = Order.where(user_id: params[:user_id], renter_id: params[:id]).first) && order.destroy
      state = 'removed'
    else
      state = 'created' if Order.create!(user_id: params[:user_id], renter_id: params[:id], skip_payment: true)
    end

    respond_to do |format|
      format.js {
        case state
          when 'created'
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
        format.html { redirect_to @renter, notice: 'Запись успешно добавлена.' }
        format.json { render action: 'show', status: :created, location: @renter }
      else
        format.html { render action: 'new' }
        format.json { render json: @renter.errors, status: :unprocessable_entity }
      end
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

  private
  def sort_column
    Renter.column_names.include?(params[:sort]) ? params[:sort] : "updated_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_renter
    @renter = Renter.find(params[:id])
    @renter = current_user.renters.find(params[:id]) if current_user.has_role?(:manager)
  end

  def create_order
    @renter.create_order(current_user) if current_user.has_role?(:realtor) || current_user.has_role?(:vip_realtor)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def renter_params
    params.require(:renter).permit(:phone, :email, :guard_time, :town, :rooms, :amount, :amount_grn, :check_in, :check_out, :description)
  end
end
