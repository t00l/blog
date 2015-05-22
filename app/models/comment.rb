class Comment < ActiveRecord::Base
  validates :comment, presence: true

  belongs_to :post #comentarios pertenece a un solo post
  belongs_to :user
  
  has_many :votecomments
  has_many :user_comments_votes, through: :votecomments, source: :user
end
