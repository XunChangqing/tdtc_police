#require 'AbstractController'
class User < ActiveRecord::Base
  #before_save :default_values
  before_validation :default_values
  ROLES = %w[user.user_admin user.reporter user.case_admin user.seria_admin user.image_resource_admin user.analysisor_admin user.checker]

  validates :username, presence: true, length: { maximum: 50 },
    uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 255 }, allow_blank: true,
    format: { with: VALID_EMAIL_REGEX }
    #uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true
  #validates :password_confirmation, presence: true
  #
  ORGS = %w[org.top org.changde org.changsha]
  validates :orgnization, presence: true
  validates_each :orgnization do |record, attr, value|
    record.errors.add attr, :invalid if not ORGS.include? value
  end

  STATUS = %w[user.status.signup user.status.normal user.status.outofuse]
  validates :status, presence: true
  validates_each :status do |record, attr, value|
    record.errors.add attr, :invalid if not STATUS.include? value
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end

  private
  def default_values
    self.status ||= 'user.status.signup'
  end
end
