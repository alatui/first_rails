class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    #http://www.justinweiss.com/articles/4-simple-memoization-patterns-in-ruby-and-one-gem/
  end

  def logged_in?
    !!current_user #convert to boolean
  end

  def require_user
    if !logged_in?
      flash[:danger] = 'You must be logged in'
      redirect_to root_path
    end
  end

end
