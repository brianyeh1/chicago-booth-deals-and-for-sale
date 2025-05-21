# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  message    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  buyer_id   :integer
#  item_id    :integer
#  seller_id  :integer
#
class Message < ApplicationRecord
end
