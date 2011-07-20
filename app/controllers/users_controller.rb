class UsersController < ApplicationController
  before_filter :authenticate_admin!, :only => [:toggle_user_retire]
  before_filter :authenticate_user!, :except => [:edit, :update, :toggle_user_retire]
  before_filter :ensure_self_or_admin, :only => [:edit, :update]
  
  
  def ensure_self_or_admin
    if !admin_signed_in? && (current_user.id.to_s != params[:id])
      flash[:notice] = "Can't do that if not an admin!"
      redirect_to access_denied_users_path
    end
  end
  
  def index
  end
  def edit
    @user = User.find(params[:id])
  end
  def show
  end
  def update
    User.find(params[:id]).update_attributes(params[:user])

    flash[:notice] = "user updated!"
    redirect_to :back
  end
  
  def toggle_user_tutorial
    @user = current_user
    @user.update_attribute(:tutorial_complete, !@user.tutorial_complete)
    render :nothing => true
  end
  
  def toggle_user_retire
    @user = User.unscoped.find(params[:user_id])
    @user.update_attribute(:retired, !@user.retired)
    render :nothing => true
  end
  
  def access_denied
    
  end
end
