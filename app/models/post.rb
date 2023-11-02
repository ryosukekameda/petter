class Post < ApplicationRecord
  has_one_attached :post_image
  
  has_many :favorite, dependent: :destroy
  has_many :commnet, dependent: :destroy
  has_many :post_tag, dependent: :destroy
  
  belongs_to :user
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
