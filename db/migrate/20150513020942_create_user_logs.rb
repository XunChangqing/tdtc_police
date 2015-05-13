class CreateUserLogs < ActiveRecord::Migration
  def change
    create_table :user_logs do |t|
      t.references :user, index: true, foreign_key: true
      t.string :operation
      t.string :target_user
      t.text :remark

      t.timestamps null: false
    end
  end
end
