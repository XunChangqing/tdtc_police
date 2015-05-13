class CreateAuthorityChangeRequests < ActiveRecord::Migration
  def change
    create_table :authority_change_requests do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :src_authority
      t.integer :dst_authority
      t.text :user_remark
      t.text :manager_remark
      t.string :status

      t.timestamps null: false
    end
  end
end
