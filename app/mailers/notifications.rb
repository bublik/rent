class Notifications < ActionMailer::Base
  default(from: "noreplay@clubweb.com.ua", return_path: 'noreplay@clubweb.com.ua')

  def new_renter(user, renter)
    @user = user
    @renter = renter.decorate

    mail to: user.email, subject: "[#{renter.town}] Новое объявление"
  end

  # TODO
  def access_to_renter
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
