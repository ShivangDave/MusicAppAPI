class UsersController < ApplicationController

  before_action :find_user, only: [:destroy]

  def index
    @users = User.all
    render :json => { :users => @users }, :status => :ok
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      render :json => { :user => @user }, :status => :ok
    else
      render :json => { :error => "User creation failed." }, :status => :bad_request
    end
  end

  def destroy
    @user.destroy
    if !@user.persisted?
      render :json => { :message => "User destroyed." }, :status => :ok
    else
      render :json => { :message => "User destruction failed." }, :status => :ok
    end
  end

  private
  def user_params
    params.require(:user).permit(:username,:password_digest)
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end

end
