class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.order("created_at DESC")
    @comment = Comment.new
    @user = User.new
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
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
    @post = Post.new(create_params)
    @post.user_id = current_user.id
    @post.time = Time.now
    if @post.save
      flash[:success] = "User has been created."
      redirect_to post_path(@post)
    else
      flash.now[:danger] = "There's seem to be an error."
      render :new

    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post.update(update_params)
    if @post.save
      flash[:success] = "Updated."
      redirect_to @post
    else
      flash.now[:danger] = "Update fail."
      render :edit
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

  private
  def create_params
    params.require(:post).permit(:caption, {images: []})
  end

  def update_params
    params.require(:post).permit(:caption)
  end


  def find_post
    @post = Post.find(params[:id])
  end
end
