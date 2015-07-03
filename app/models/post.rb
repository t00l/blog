class Post < ActiveRecord::Base
	
	include PgSearch

	validates :titulo, presence: true
	validates :content, presence: true

	has_many :comments, dependent: :destroy #en plural, por que tiene muchos comentarios. 
	#depene de post, para que al borrar el post se eliminen los comentarios.
	belongs_to :user
	#estas dos uyltimas se relacionan a traves de through
	has_many :votes
	has_many :user_votes, through: :votes, source: :user
	
	#buscarqueda multisearch
	multisearchable against: [:titulo, :content]
	#busqueda con scope, mas ajustada o costumize
	pg_search_scope :search_by_title_or_content, against: [:titulo, :content]
	pg_search_scope :search_by_title, against: [:titulo]
	pg_search_scope :search_by_content, against: [:content]

	#busqueda tabla asociada
	pg_search_scope :search_by_author, associated_against: {
    user: [:name]}
    pg_search_scope :search_no_strict, against: [:titulo, :content], using: {tsearch: {prefix: :true}}


end
