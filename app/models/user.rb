class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image    
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post
  # フォロー機能
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_users, through: :followers, source: :followed
  has_many :follower_users, through: :followeds, source: :follower
  
  def follow(user_id)
    followers.create(followed_id: user_id)
  end 
  
  def unfollow(user_id)
    followers.find_by(followed_id: user_id).destroy
  end 
  
  def following?(user)
    following_users.include?(user)
  end

  # ユーザーステータス
  def active_status
    is_active ? "有効" : "退会済み"
  end

  # 退会済みアカウントの処理
  def active_for_authentication?
    super && (is_active == true)
  end

  # プロフィール写真
  def get_profile_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_fill: [width, height]).processed
    else
      'no_profile.jpg'
    end 
  end
  
  # 検索機能
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?", "#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?", "%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?", "%#{word}%")
    else
      @user = User.all
    end
  end

  # ゲストログイン機能
  def self.guest
    find_or_create_by!(email: 'uest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end
  #いいねされているか確認
  def favorited?(post)
    favorites.exists?(post_id: post.id)
  end
end
