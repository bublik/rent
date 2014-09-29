class Notifications < ActionMailer::Base
  default(from: "noreplay@mkc.od.ua", return_path: 'noreplay@mkc.od.ua')

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
    mail to: admin.email, subject: "Новый пользователь зарегистрировался" #[#{renter.town}]
  end
end
