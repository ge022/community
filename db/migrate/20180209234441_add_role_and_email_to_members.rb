class AddRoleAndEmailToMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :role, :string
    add_column :members, :email, :string
  end
end
