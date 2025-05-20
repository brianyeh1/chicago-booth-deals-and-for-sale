# == Schema Information
#
# Table name: items
#
#  id              :bigint           not null, primary key
#  category        :string
#  delivery_method :string
#  description     :string
#  name            :string
#  payment_method  :string
#  picture_1       :string
#  picture_2       :string
#  picture_3       :string
#  picture_4       :string
#  picture_5       :string
#  price           :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  seller_id       :integer
#
class Item < ApplicationRecord
  validates(:name, presence: true)
  validates(:description, presence: true)
  validates(:price, presence: true)
  mount_uploader :picture_1, Picture1Uploader
end
