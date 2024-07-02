class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :title,presence: true
  validates :content,presence: true
  has_many :post_comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :taggings
  has_many :tags,through: :taggings
  
  #いいね定義
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end   
  
  #検索方法定義
  def self.looks(search,word)
    if search == "perfect_match"
      @post = Post.where("title Like?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("title Like?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("title Like?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("title_Like?","%#{word}%")
    else 
      @post = Post.all
    end   
  end     
  
  #ソート機能
   scope :latest,->{order(created_at: :desc)}
   scope :old,->{order(created_at: :asc)}
   scope :favorite_count,->{
     left_joins(:favorites)
     .group(:id)
     .order('COUNT(favorites.id) DESC')
   }
end
