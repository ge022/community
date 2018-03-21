class AddUserToForumAndArticles < ActiveRecord::Migration[5.1]
  def change
    add_reference :forums, :user, foreign_key: true
    add_reference :forum_replies, :user, foreign_key: true
  end
end
