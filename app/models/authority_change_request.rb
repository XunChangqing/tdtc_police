class AuthorityChangeRequest < ActiveRecord::Base
  before_validation :default_values
  belongs_to :user
  validates :user_id, presence:true

  STATUS = %w[user.acr.status.submited user.acr.status.accepted user.acr.status.rejected]
  validates :status, presence: true
  validates_each :status do |record, attr, value|
    record.errors.add attr, :invalid if not STATUS.include? value
  end

  def src_roles=(roles)
    self.src_authority = (roles & User::ROLES).map { |r| 2**User::ROLES.index(r) }.inject(0, :+)
  end

  def src_roles
    User::ROLES.reject do |r|
      ((src_authority.to_i || 0) & 2**User::ROLES.index(r)).zero?
    end
  end

  def dst_roles=(roles)
    self.dst_authority = (roles & User::ROLES).map { |r| 2**User::ROLES.index(r) }.inject(0, :+)
  end

  def dst_roles
    User::ROLES.reject do |r|
      ((dst_authority.to_i || 0) & 2**User::ROLES.index(r)).zero?
    end
  end

  #def is?(role)
    #roles.include?(role.to_s)
  #end

  private
  def default_values
    self.status ||= 'user.acr.status.submited'
  end
end
