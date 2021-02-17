class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception 
    include ApplicationHelper 
    
    helper_method :current_user, :logged_in? 


    private

    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!session[:user_id]
    end

    def redirect_if_not_logged_in
        if !logged_in?
            flash[:error] = "You must be logged in to perform that action"
            redirect_to '/' if !logged_in?
        end
    end
end   
