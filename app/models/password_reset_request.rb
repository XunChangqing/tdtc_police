class PasswordResetRequest < ActiveRecord::Base
  before_validation :default_values
  belongs_to :user

  validates :user_id, presence:true

  STATUS = %w[user.prr.status.submit user.prr.status.processed]
  validates :status, presence: true
  validates_each :status do |record, attr, value|
    record.errors.add attr, :invalid if not STATUS.include? value
  end

  private
  def default_values
    self.status ||= 'user.prr.status.submit'
  end
end
