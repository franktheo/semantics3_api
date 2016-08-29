class SessionsController < ApplicationController

  skip_before_action :authorize

  def new
  end

 def create
    @user = User.where(username: params[:username]).first
    if @user
      session[:user_id] = @user.id
      case current_user.role
        when "admin"
          redirect_to search_results_product_path
        when "guest"
          redirect_to search_results_product_path
      end
    else
      session[:user_id] = nil
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end
