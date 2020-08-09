class AddFieldToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :mobile_number, :string
    add_column :users, :is_verified, :boolean, default: false
    add_column :users, :verify_otp, :string
  	change_column :users, :email, :string, null: true
  end
end