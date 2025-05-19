class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :category
      t.integer :item_id
      t.string :picture_1
      t.string :picture_2
      t.string :picture_3
      t.string :picture_4
      t.string :picture_5
      t.float :price
      t.string :payment_method
      t.integer :seller_id
      t.string :description
      t.string :delivery_method

      t.timestamps
    end
  end
end
