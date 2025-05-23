# == Schema Information
#
# Table name: saves
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :integer
#  user_id    :integer
#
class Save < ApplicationRecord
validates(:user_id, presence: true)
validates(:item_id, presence: true)
validates(:user_id, uniqueness: { scope: :item_id, message: "Listing already saved"})
has_many(:item, class_name: "Item", foreign_key: "id", primary_key: "item_id")

end
