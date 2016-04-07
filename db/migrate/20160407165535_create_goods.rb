class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.string :name, null: false
      t.integer :quantity, null: false
      t.references :boat, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
