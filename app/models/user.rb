class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post, dependent: :destroy
  has_many :favorite, dependent: :destroy
  has_many :comment, dependent: :destroy
  has_many :followings_id, dependent: :destroy
  has_many :followiners_id, dependent: :destroy
end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.nickname = "げすと"
      user.is_deleted = false
    end
  end