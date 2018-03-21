class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.string :display_name
      t.references :community, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
