class CreateBoats < ActiveRecord::Migration
  def change
    create_table :boats do |t|
      t.string :name, null: false
      t.integer :year, null: false
      t.references :user, index: true, foreign_key: true
      t.attachment :image

      t.timestamps null: false
    end
  end
end
