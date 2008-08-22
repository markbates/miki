module Miki
  module Authentication
    
    def authorized?
      if is_logged_out?
        session[:return_to_url] = request.fullpath
        redirect_to(login_url)
        return false
      end
      return true
    end
    
    def is_logged_in?
      !session[:user_id].blank?
    end

    def is_logged_out?
      session[:user_id].blank?
    end
    
    def current_user
      ivar_cache do
        unless session[:user_id].blank?
          User.get!(session[:user_id])
        end
      end
    end
    
    include_safely_into(Mack::Controller, Mack::Rendering::ViewTemplate)
    
  end
end