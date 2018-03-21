class AddTypetoArticleComments < ActiveRecord::Migration[5.1]
  def change
    add_column :article_comments, :article_type, :string
  end
end
