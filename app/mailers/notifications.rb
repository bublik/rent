class Notifications < ActionMailer::Base
  default(from: "noreplay@clubweb.com.ua", return_path: 'noreplay@clubweb.com.ua')

  def new_renter(user, renter)
    @user = user
    @renter = renter.decorate

    mail to: user.email, subject: "[#{renter.town}] Новое объявление"
  end

  def access_to_renter(user, renter)
    @user = user
    @renter = renter.decorate

    mail to: user.email, subject: "[#{renter.town}] Горячее объявление!"
  end

  def new_public_renter(user, renter)
    @user = user
    @renter = renter.decorate

    mail to: user.email, subject: "[#{renter.town}] Новое объявление"
  end

end
