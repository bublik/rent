class Notifications < ActionMailer::Base
  default(from: '"mkc.od.ua" <noreplay@mkc.od.ua>', return_path: '"mkc.od.ua" <noreplay@mkc.od.ua>')

  helper :application

  # def send_renter(user, renter)
  #   @renter = renter.decorate
  #   mail to: user.email, subject: "Подано - Новое объявление" #[#{renter.town}]
  # end

  def new_renter(user, renter)
    @user = user
    @renter = renter.decorate
    @agent = renter.user.name
    mail to: user.email, subject: "Новое объявление" #[#{renter.town}]
  end

  def access_to_renter(user, renter)
    @user = user
    @renter = renter.decorate

    mail to: user.email, subject: "Горячее объявление!" #[#{renter.town}]
  end

  def new_public_renter(user, renter)
    @user = user
    @renter = renter.decorate

    mail to: user.email, subject: "Новое объявление" #[#{renter.town}]
  end

  def send_admin_notification(admin, user)
    @user = user
    @admin = admin
    mail to: admin.email, subject: "Новый пользователь зарегистрировался" #[#{renter.town}]
  end

  def feedback(feedback, admin)
    @feedback = feedback
    mail to: admin.email, subject: "Обратная связь" #[#{renter.town}]
  end
end
