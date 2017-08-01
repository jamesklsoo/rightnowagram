class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    @filterrific = initialize_filterrific(User, params[:filterrific],
                                          select_options: {
                                            sorted_by: User.options_for_sorted_by
                                          },
                                          ) or return

    @users = @filterrific.find

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user_post = @user.posts.order("created_at DESC")
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User has been created"
      redirect_to root_path
    else
      flash.now[:danger] = "Invalid input"
      render :new
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user.update(update_params)
    if @user.save(validate: false)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      flash.now[:danger] = "Update failed"
      render :edit
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user.password == params[:password]
      give_token
    else
      redirect_to home_url
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :fullname, :username, :password)
  end

  def update_params
    #need to add website and other instagrams options in table
    params.require(:user).permit(:email, :fullname, :username, :password, :website, :bio, :gender, :phone_num, :avatar)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
