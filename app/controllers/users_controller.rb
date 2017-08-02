class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
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
    if !(logged_in?)
      redirect_to new_user_path
    elsif params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(current_user)
  end

  # POST /users
  # POST /users.json
  def create
    user = User.new(user_params)
    if user.save
      flash[:success] = "Congratulations! You have successfully created an account!"
    else
      flash[:error] = "There is an error with creating your account!"
    end
    redirect_to new_session_path
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if current_user.update(user_params)
      flash[:message] = "Successfully updated your account!"
      redirect_to "/"
    else
      flash[:error] = current_user.errors.messages
      redirect_to edit_user_path(current_user)
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

  private

  def user_params
    params.require(:user).permit(:money, :last_name, :first_name, :email, :password, :avatar)
  end
end
