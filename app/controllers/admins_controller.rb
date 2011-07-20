class AdminsController < ApplicationController
  before_filter :authenticate_admin!
  def index
    @all_users = User.all
  end
end
