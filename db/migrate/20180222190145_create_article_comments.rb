class CreateArticleComments < ActiveRecord::Migration[5.1]
  def change
    create_table :article_comments do |t|
      t.integer :author_id
      t.text :comment
      t.references :article, foreign_key: true
      t.references :community, foreign_key: true

      t.timestamps
    end
  end
end
