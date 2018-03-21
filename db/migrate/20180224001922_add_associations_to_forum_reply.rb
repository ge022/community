class AddAssociationsToForumReply < ActiveRecord::Migration[5.1]
  def change
    add_column :forum_replies, :forum_commentable_id, :integer
    add_column :forum_replies, :forum_commentable_type, :string
  end
end
