class AddAdminIdToCommunities < ActiveRecord::Migration[5.1]
  def change
    add_column :communities, :adminID, :integer
  end
end
