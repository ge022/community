class CreateForums < ActiveRecord::Migration[5.1]
  def change
    create_table :forums do |t|
      t.references :community, foreign_key: true
      t.integer :author_id
      t.string :title
      t.text :post

      t.timestamps
    end
  end
end
