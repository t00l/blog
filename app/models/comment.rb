class Comment < ActiveRecord::Base
  belongs_to :post #comentarios pertenece a un solo post
end
