class PostsController < ApplicationController
  load_and_authorize_resource #para que no ingrese por la ruta del navegador. se aplica
  #a todos los metodos
  before_action :authenticate_user!, except: [:index, :show]

  # GET /posts
  # GET /posts.json
  def index
    if params.key?(:query) && !params[:query].empty?
      #problematic_record.published?     # => false
      @posts = []
      PgSearch.multisearch(params[:query]).where(searchable_type: "Post").find_each do |element|
      @posts << element.searchable 
      end
    else
        @posts = Post.all.page(params[:page])
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    #@comment = Comment.new(post:@post)
    #lo de abajo hace lo mismo de arriba.
    @comment = @post.comments.build

    #tenemos que mostrar todos los comentarios del post y pasarlos a la vista
    @comments = @post.comments.all #muestra el arreglo de todos los comentarios

  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user#asociamos comentario al id del usuario
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #metodo para votar por post.
  def upvote
    @post = Post.find(params[:id])
    @vote = @post.votes.build(user:current_user)
    #el build pasa el post_id y falta pasar el usuario, que se pone al final como
    #current user


    if @post.user_votes.include? current_user
    #si eres el usuario que ya voto en el post
        @post.votes.where(user: current_user).first.delete
        #borra el upvote
        redirect_to @post, notice: 'Tu voto se ha eliminado :'
    elsif @vote.save
      redirect_to @post, notice: 'Gracias por el voto'
    else
      redirect_to @post, alert: 'No se pudo votar'
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:titulo, :content)
    end
end
