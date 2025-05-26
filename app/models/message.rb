# == Schema Information
#
# Table name: messages
#
#  id             :bigint           not null, primary key
#  buyer_message  :string
#  seller_message :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  buyer_id       :integer
#  item_id        :integer
#  seller_id      :integer
#
class Message < ApplicationRecord
    validates(:message, presence: true)
    validates(:seller_id, presence: true)
    validates(:buyer_id, presence: true)
end
