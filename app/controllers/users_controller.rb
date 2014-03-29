class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @role = params[:role]
    @users = User.with_role(@role)

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
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
  end

  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])

#    user_params.delete(:current_password)

    if @user.update_attributes(user_params)
      redirect_to users_path, :notice => "Пользователь изменен!"
    else
      logger.debug(@user.errors.full_messages.inspect)
      redirect_to users_path, :alert => "Невозможно изменить пользователя."
    end
  end

  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
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
  def user_params
    params.require(:user).permit(:name, :email, :phone, :description, :subscribe, :role_ids, :free_orders, :password, :password_confirmation)
  end
end