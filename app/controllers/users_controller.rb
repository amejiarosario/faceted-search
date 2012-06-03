class UsersController < ApplicationController
  
  def index
    @users = User.all
    authorize! :view, @users.first
  end
  
  def edit
    @user = User.find(params[:id])
    authorize! :edit, @user
  end
 
  def update
    @user = User.find(params[:id])
    authorize! :update, @user
    
    if @user.update_attributes(params[:user])
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    authorize! :destroy, @user
    @user.destroy
    redirect_to users_path
  end
  
end
