class AddcommentabletoArticleComments < ActiveRecord::Migration[5.1]
  def change

    add_column :article_comments, :article_commentable_type, :string
    add_column :article_comments, :article_commentable_id, :integer
  end
end
