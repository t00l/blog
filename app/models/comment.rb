class Comment < ActiveRecord::Base
  validates :comment, presence: true

  belongs_to :post #comentarios pertenece a un solo post
end
