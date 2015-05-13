class Post < ActiveRecord::Base
	has_one :comments #en plural, por que tiene muchos comentarios
end
