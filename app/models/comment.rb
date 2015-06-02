class Comment < ActiveRecord::Base
  validates :comment, presence: true

  belongs_to :post , counter_cache: true#comentarios pertenece a un solo post
  #counter cache va en el modelo con belongs to
  belongs_to :user
  
  has_many :votecomments
  has_many :user_comments_votes, through: :votecomments, source: :user
end
