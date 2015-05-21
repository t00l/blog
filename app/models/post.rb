class Post < ActiveRecord::Base
	validates :titulo, presence: true
	validates :content, presence: true

	has_many :comments, dependent: :destroy #en plural, por que tiene muchos comentarios. 
	#depene de post, para que al borrar el post se eliminen los comentarios.
	belongs_to :user
	#estas dos uyltimas se relacionan a traves de through
	has_many :votes
	has_many :user_votes,through: :votes, source: :user
end
