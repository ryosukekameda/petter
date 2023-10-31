class Post < ApplicationRecord
  has_one_attached :image
  
  has_many :favorite, dependent: :destroy
  has_many :commnet, dependent: :destroy
  has_many :post_tag, dependent: :destroy
  
  belongs_to :user
end
