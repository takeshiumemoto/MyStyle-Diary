class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image    
  has_many :posts,dependent: :destroy
  has_many :post_comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
 #ユーザーステータス
  def active_status
    is_active ? "有効" : "退会済み"
  end
  
  #退会済みアカウントの処理
    def active_for_authentication?
      super && (is_active==true)
    end   
  #プロフィール写真
  def get_profile_image(width,height)
    if profile_image.attached?
      profile_image.variant(resize_to_fill: [width, height]).processed
    else
      'no_profile.jpg'
    end 
  end   
  
  #検索機能
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
end
