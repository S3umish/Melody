class SessionsController < ApplicationController

    def welcome
    end
  
    def destroy
      session.delete(:user_id)
      redirect_to '/'
    end
  
    def new
    end
  
    # Normal Login
    def create
      user = User.find_by(username: params[:user][:username])
        if user && user.authenticate(params[:user][:password])
          session[:user_id] = user.id
          redirect_to user_path(user)
          flash[:message] = "Hello and Welcome!"
        else
          flash[:error] = "Invalid Credentials , Please try again !!"
          redirect_to login_path
      end
    end

end
