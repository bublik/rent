class AccessDecorator < Draper::Decorator
  delegate_all

  def user
    user = object.user
    user.name.blank? ? user.email : user.name
  end

end