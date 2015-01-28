class RenterDecorator < Draper::Decorator
  delegate_all

  def town
    object.town ? object.town.name : ''
  end

  def phone
    h.icon_tag('phone') + ' ' + h.number_to_phone(object.phone)
  end

  def phone_masked
    h.icon_tag('phone') + ' ' + h.number_to_phone(mask(object.phone))
  end

  def amount_from
    h.number_to_currency(object.amount_from, precision: 0, unit: 'гр')
  end

  def amount_to
    h.number_to_currency(object.amount_to, precision: 0, unit: 'гр')
  end

  def email
    object.email.blank? ? '' : h.icon_tag('envelope') + ' ' + h.mail_to(object.email)
  end

  def people
    object.people && "#{object.people} чел"
  end

  def rooms
    "#{object.rooms} ком"
  end

  def description(action_name = 'index')
    action_name.eql?('index') ? h.truncate(object.description, length: 90) : object.description
  end

  def guard_time
    h.l(object.guard_time, format: :short)
  end

  def check_in
    object.show_check_in ?
    h.content_tag(:span, h.l(object.check_in, format: :check), class: 'label label-success') : ''
  end

  def check_out
    object.show_check_out ?
    (object.check_out && h.content_tag(:span, h.l(object.check_out, format: :check), class: 'label label-default ')) : ''
  end

  def created_at
    h.l(object.created_at, format: :short)
  end

  def updated_at
    h.l(object.updated_at, format: :short)
  end

  def published_at(format = :short)
    object.published_at ? h.l(object.published_at, format: format) : '-'
  end

  private
  def last_digits(number)
    number.to_s.length <= 2 ? number : number.to_s.slice(0..-3)
  end

  def mask(number)
    "#{last_digits(number)}XX"
  end
end
