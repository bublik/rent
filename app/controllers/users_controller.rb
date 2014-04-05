class UsersController < ApplicationController
  before_filter :init_user, only: [:edit, :show, :update, :destroy]
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Вы не авторизированы как администратор.'
    @role = params[:role]

    @users = User.has_role(@role)

    respond_to do |format|
      format.html {}
      format.js { render partial: 'users', format: :html, layout: false }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'Запись успешно добавлена.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def show
    authorize! :index, @user, :message => 'Вы не авторизированы как администратор.'
  end

  def update
    authorize! :update, @user, :message => 'Вы не авторизированы как администратор.'
    if order = user_params.delete('order')
      logger.debug(order)
      order.eql?('plus') ? @user.increment(:free_orders) : @user.decrement(:free_orders)
    end

    @user.attributes = user_params
    respond_to do |format|
      if @user.save
        format.html { redirect_to :back, :notice => "Пользователь изменен!" }
        format.js { flash.now[:notice] = 'Данные изменены'}
      else
        errors = @user.errors.full_messages.join(',')
        format.html { redirect_to :back, :alert => "Невозможно изменить пользователя." }
        format.js { flash.now[:alert] = errors }
      end
    end
  end

  def destroy
    authorize! :destroy, @user, :message => 'Вы не имеете прав на эту операцию.'
    unless @user == current_user
      @user.destroy
      redirect_to users_path, :notice => "Пользователь удален."
    else
      redirect_to users_path, :notice => "Вы не можете себя удалить."
    end
  end

  def for_assign
    @users = User.with_role(params[:role])
    @assigned_user_ids = Order.where('renter_id = ?', params[:renter_id]).pluck(:user_id)
  end

  private
  def init_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone, :description, :subscribe, :current_password, :role_ids,
                                 :order, :free_orders, :password, :password_confirmation)
  end
end