class RenterDecorator < Draper::Decorator
  delegate_all

  def phone
    h.icon_tag('phone') + ' ' + h.number_to_phone(object.phone)
  end

  def amount
    h.number_to_currency(object.amount, unit: '$')
  end

  def email
    h.mail_to(object.email)
  end

  def rooms
    "#{object.rooms} ком."
  end

  def guard_time
    object.guard_time.to_s(:short)
  end

  def check_in
    h.icon_tag('home') + ' ' + object.check_in.to_s(:short)
  end
end
