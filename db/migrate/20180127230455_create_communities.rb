class CreateCommunities < ActiveRecord::Migration[5.1]
  def change
    create_table :communities do |t|
      t.string :name
      t.text :description
      t.string :promo
      t.boolean :private

      t.timestamps
    end
  end
end
