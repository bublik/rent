class RenterDecorator < Draper::Decorator
  delegate_all

  def phone
    h.icon_tag('phone') + ' ' + h.number_to_phone(object.phone)
  end

  def amount
    h.number_to_currency(object.amount, precision: 0, unit: '$')
  end

  def email
    h.icon_tag('envelope') + ' ' + h.mail_to(object.email)
  end

  def rooms
    "#{object.rooms} ком."
  end

  def guard_time
    h.l(object.guard_time, format: :short)
  end

  def check_in
    h.l(object.check_in, format: :short)
  end

  def check_out
    h.l(object.check_out, format: :short)
  end

  def created_at
    h.l(object.created_at, format: :short)
  end

  def updated_at
    h.l(object.updated_at, format: :short)
  end


end
