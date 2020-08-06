class ChangeColumnToUser < ActiveRecord::Migration[5.1]
  def change
  	change_column :users, :email, :string, null: true
  	change_column :users, :is_verify, :boolean, default: false
  end
end
