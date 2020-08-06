class AddColumnToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :mobile_number, :string
    add_column :users, :otp, :string
    add_column :users, :is_verify, :boolean
  end
end
