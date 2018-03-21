class CreateForumReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :forum_replies do |t|
      t.references :forum, foreign_key: true
      t.references :community, foreign_key: true
      t.text :post
      t.integer :author_id

      t.timestamps
    end
  end
end
