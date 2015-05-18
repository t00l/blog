class CommentsController < ApplicationController
	load_and_authorize_resource #para que no ingrese por la ruta del navegador. se aplica
  #a todos los metodos
	before_action :authenticate_user!

	#metodo que se va a llamar cuando hacemos submitenel form que estaen 
	#el show del post
	def create
		#obtener el post. Ver rake routes.
		@post = Post.find(params[:post_id])
		#ahora construimos el comentario 
		@comment = @post.comments.build(comment_params)

		@comment.user = current_user#asociamos comentario al id del usuario

		@comments = @post.comments.all
		#ahora vamos a guardar el comentario en la bd
		if @comment.save
			redirect_to @post, notice: 'El comentario se guardo con exito' #
		else
			render 'posts/show'
		end
	end

	def destroy

		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id]).destroy
		redirect_to @post

	end

	private 
			#proteccion para injeccion de datos
		def comment_params #nuestro modelo comment. Lo otro son los campos deo formulario
			params.require(:comment).permit(:comment)
		end	
end
