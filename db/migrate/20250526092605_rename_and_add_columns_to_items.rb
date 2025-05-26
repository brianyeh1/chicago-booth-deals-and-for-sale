class RenameAndAddColumnsToItems < ActiveRecord::Migration[7.1]
    def change
     # 1) Rename an existing column
     rename_column(:messages, :message, :buyer_message)

     # 2) Add a brand-new column
      add_column(:messages, :seller_message, :string)
   end
end
