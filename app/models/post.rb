class Post < ApplicationRecord
  has_one_attached :post_image
  
  has_many :favorite, dependent: :destroy
  has_many :commnet, dependent: :destroy
  has_many :post_tag, dependent: :destroy
  
  belongs_to :user
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("body LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("body LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("body LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("body LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end

  
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
