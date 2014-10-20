class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to(renters_path)
    end
  end

  def about

  end

  def administration
    @feedback = Feedback.new(params[:feedback] ? params[:feedback].permit! : {})
    @feedback.user = current_user

    @user = User.find_by_email(ENV['ADMIN_EMAIL'])
    if request.post? && @feedback.save && Notifications.feedback(@feedback, @user).deliver
      flash[:notice] = 'Ваше письмо отправлено!'
      @feedback = Feedback.new
    end
  end

end
