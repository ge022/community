class ArticlesCleanUp < ActiveRecord::Migration[5.1]
  def change
    remove_column :articles, :string, :varchar
    remove_column :articles, :text, :varchar
    remove_column :articles, :community, :varchar
    remove_column :articles, :references, :varchar
    remove_column :articles, :article, :varchar
    add_column :articles, :title, :string
    add_column :articles, :article, :text
    add_reference :articles, :community, foreign_key:true


  end
end
