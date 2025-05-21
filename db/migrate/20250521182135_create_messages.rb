class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.integer :item_id
      t.integer :seller_id
      t.integer :buyer_id
      t.string :message

      t.timestamps
    end
  end
end
