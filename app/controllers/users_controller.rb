class UsersController < ApplicationController
  include SessionsHelper    
    
  before_action :correct_user,   only: [:show, :edit, :update, :destroy]
  before_action :set_timezone
  def set_timezone
    Time.zone = current_user.time_zone || 'UTC'
  end
  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
      
  end

  # GET /users/new
  def new
    redirect_to root_path, notice: "Please sign in. users#new" if signed_in?
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    redirect_to root_path, notice: "Please sign in. users#create" if signed_in?
      
    @user = User.new(user_params)
    if @user.save
        sign_in @user
        redirect_to @user, notice: 'Profile was successfully created.'
    else 
        @user.errors.full_messages.each do |msg|
            flash[("some_field_error" + msg).to_sym] = msg
        end
        redirect_to signup_path
    end
  end

  # PATCH/PUT /users/1
  def update
      params[:user].delete(:password) if params[:user][:password].blank?
      
      if @user.update_attributes(user_params)
          sign_in @user
          redirect_to @user, notice: 'Profile was successfully updated.'
      else
        @user.errors.full_messages.each do |msg|
           flash.now[("some_field_error" + msg).to_sym] = msg
        end
        render :edit
      end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    flash[:notice] = "User destroyed."
    redirect_to users_url
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :birth_date, :password, :password_confirmation, :avatar, :time_zone)
    end
  
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
