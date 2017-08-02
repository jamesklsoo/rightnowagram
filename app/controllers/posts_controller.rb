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
    @post = Post.find(params[:id])
    @comment = Comment.new
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
    post = current_user.posts.new(post_params)
    if post.save
      flash[:success] = "You have successfully created a post!"
      redirect_to root_path
    else
      flash[:error] = "There was an error creating your post!"
      redirect_to new_post_path
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

  def post_params
    params.require(:post).permit(:title, :story)
  end
end
