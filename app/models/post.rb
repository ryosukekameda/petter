class Post < ApplicationRecord
  has_one_attached :post_image
  
  has_many :favorite, dependent: :destroy
  has_many :commnet, dependent: :destroy
  has_many :post_tag, dependent: :destroy
  
  belongs_to :user
  
  def self.ransackable_attributes(auth_object = nil)
     ["commnet", "favorite", "post_image_attachment", "post_image_blob", "post_tag", "user"]
  end
  # 上記変える
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      post_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
      post_image.variant(resize_to_limit: [width, height]).processed
  end
end
