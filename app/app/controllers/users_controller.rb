class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def edit
    @user = User.find_by(id: params[:id])
    render :edit
  end

  def update
    @user = User.find_by(id: params[:id])

    if @user.update_attributes(user_params)
      redirect_to user_url(@user)
    else
      # flash errors
      render :edit
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # login!(@user)
      redirect_to user_url(@user)
    else
      # flash errors
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    render :show
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    render :new
  end



  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
