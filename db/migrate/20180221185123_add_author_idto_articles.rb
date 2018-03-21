class AddAuthorIdtoArticles < ActiveRecord::Migration[5.1]
  def change
    rename_column :articles, :author, :author_id
    change_column :articles, :author_id, :int
  end
end
