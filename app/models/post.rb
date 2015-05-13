class Post < ActiveRecord::Base
	has_many :comments #en plural, por que tiene muchos comentarios
end
