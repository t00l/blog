class CommentsController < ApplicationController

	#metodo que se va a llamar cuando hacemos submitenel form que estaen el show del post
	def create
		#obtener el post. Ver rake routes.
		@post = Post.find(params[:post_id])
		#ahora construimos el comentario 
		@comment = @post.comments.build(comments_params)
		@comments = @post.comments.all
		#ahora vamos a guardar el comentario en la bd
		if @comment.save
			redirect_to @post, notice: 'El comentario se guardo con exito' #
		else
			render 'posts/show'
		end
	end

	private 
		#proteccion para injeccion de datos
	def comments_params #nuestro modelo comment. Lo otro son los campos deo formulario
		params.require(:comment).permit(:comment)
	end
end
