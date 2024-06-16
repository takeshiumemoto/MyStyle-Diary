class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :title,presence: true
  validates :content,presence:true
  has_many :post_comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
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
end
