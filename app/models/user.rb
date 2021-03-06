# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  invitation_token       :string(255)
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  invitations_count      :integer          default(0)
#  phone                  :string(255)
#  description            :string(255)
#  orders_count           :integer          default(0), not null
#  renters_count          :integer          default(0), not null
#  free_orders            :integer          default(0), not null
#  subscribe              :boolean          default(TRUE), not null
#  auth_token             :string(255)
#

class User < ActiveRecord::Base
  ROLES = ['admin', 'manager', 'realtor', 'vip_realtor']

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :renters
  has_many :orders
  scope :subscribers, -> { where(subscribe: true) }
  scope :has_role, lambda { |role| includes(:roles).where(:roles => {:name => role}) }

  attr_accessor :order
  validates_numericality_of :free_orders, greater_than_or_equal_to: 0, only_integer: true, allow_nil: false

  before_save :disable_subscription, if: -> { self.has_role?(:manager) }
  before_save :check_auth_token
  after_create :send_admin_notification

  def disable_subscription
    self.subscribe = false
    true
  end

  def is_admin?
    self.has_role?(:admin)
  end

  def is_manager?
    self.has_role?(:manager)
  end

  def is_realtor?
    self.has_role?(:realtor)
  end

  def is_vip_realtor?
    self.has_role?(:vip_realtor)
  end

  def self.admin
    User.has_role(:admin).first
  end

  # inform first admin about new user for more fast verification
  def send_admin_notification
    Notifications.send_admin_notification(User.admin, self).deliver
  end

  def check_auth_token
    self.auth_token = SecureRandom.uuid.gsub('-','').upcase if self.auth_token.blank?
  end
end
