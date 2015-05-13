class UserLog < ActiveRecord::Base
  belongs_to :user
  OPERATIONS = %w[user.log.op.signup user.log.op.password_reset user.log.op.role_change_request user.log.op.role_change_cancel user.log.op.approve user.log.op.new_user user.log.op.destroy_user user.log.op.modify_user user.log.op.process_reset user.log.op.destroy_reset user.log.op.accept_role_change user.log.op.reject_role_change user.log.op.destroy_role_change]

  validates :operation, presence: true
  validates_each :operation do |record, attr, value|
    record.errors.add attr, :invalid if not OPERATIONS.include? value
  end
end
