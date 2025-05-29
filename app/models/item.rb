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
#  status          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  seller_id       :integer
#
class Item < ApplicationRecord
  validates(:name, presence: true)
  validates(:description, presence: true)
  validates(:price, presence: true)
  validates(:status, presence: true)
  validates(:price, numericality: true)
  mount_uploader :picture_1, Picture1Uploader
  mount_uploader :picture_2, Picture2Uploader
  mount_uploader :picture_3, Picture3Uploader
  mount_uploader :picture_4, Picture4Uploader
  mount_uploader :picture_5, Picture5Uploader
  
  def self.ransackable_attributes(auth_object = nil)
    return ["name", "description"]
  end

  # allow no associations (since you’re only searching your own columns)
  def self.ransackable_associations(auth_object = nil)
    return []
  end
end
