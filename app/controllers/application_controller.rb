class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # TWH for JSON api access
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
end
