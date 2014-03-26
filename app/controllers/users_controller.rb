class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to users_path, :notice => "Пользователь изменен!"
    else
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
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :phone, :description)
    params.require(:user).permit(:role_ids, :free_orders) if current_user.has_role?(:admin)
  end
end