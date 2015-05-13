class AddOrgnizationToUser < ActiveRecord::Migration
  def change
    add_column :users, :orgnization, :string
  end
end
