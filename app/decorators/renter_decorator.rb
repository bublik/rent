class RenterDecorator < Draper::Decorator
  delegate_all

  def phone
    h.icon_tag('phone') + ' ' + h.number_to_phone(object.phone)
  end

  def amount
    h.number_to_currency(object.amount, precision: 0, unit: '$')
  end

  def amount_grn
    h.number_to_currency(object.amount_grn, precision: 0, unit: 'гр')
  end

  def email
    h.icon_tag('envelope') + ' ' + h.mail_to(object.email)
  end

  def rooms
    "#{object.rooms} ком."
  end

  def description(action_name = 'index')
    action_name.eql?('index') ? h.truncate(object.description, length: 60) : object.description
  end

  def guard_time
    h.l(object.guard_time, format: :short)
  end

  def check_in
    h.content_tag(:span, h.l(object.check_in, format: :check), class: 'label label-success')
  end

  def check_out
    object.check_out && h.content_tag(:span, h.l(object.check_out, format: :check), class: 'label label-default')
  end

  def created_at
    h.l(object.created_at, format: :short)
  end

  def updated_at
    h.l(object.updated_at, format: :short)
  end

  def published_at
    h.l(object.published_at, format: :short)
  end
end
