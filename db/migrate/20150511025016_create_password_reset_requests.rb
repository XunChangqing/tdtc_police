class CreatePasswordResetRequests < ActiveRecord::Migration
  def change
    create_table :password_reset_requests do |t|
      t.references :user, index: true, foreign_key: true
      t.text :remark
      t.string :status

      t.timestamps null: false
    end
    add_index :password_reset_requests, :status
  end
end
