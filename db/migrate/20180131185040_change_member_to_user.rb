class ChangeMemberToUser < ActiveRecord::Migration[5.1]
  def change
    rename_table :members, :users
  end
end
