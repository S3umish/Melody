class SessionsController < ApplicationController

    def welcome
    end
  
    def destroy
      session.delete(:user_id)
      redirect_to '/'
    end
  
    def new
    end
  
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

    def omniauth
      user = User.create_from_omniauth(auth)
      
      if user.valid?
        session[:user_id] = user.id 
        redirect_to user_path(user)
        flash[:message] = "Hello and Welcome Google User!"
      else
        flash[:error] = user.errors.full_messages.to_sentence
        redirect_to login_path
      end
    end
     
  private 

  def auth 
    request.env['omniauth.auth']
  end

end
