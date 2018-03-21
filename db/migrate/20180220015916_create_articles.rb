class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :author
      t.string :string
      t.string :article
      t.string :text
      t.string :community
      t.string :references

      t.timestamps
    end
  end
end
