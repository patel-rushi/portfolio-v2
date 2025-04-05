class SessionController < ApplicationController
    def login
        authenticate_or_request_with_http_basic do |name, password|
            if User.find_by(name:)&.authenticate(password)
                session[:logged_in] = true
                redirect_to root_path, notice: 'Successfully logged in.'
            else
                request_http_basic_authentication
            end
        end
    end

    def logout
        reset_session
        redirect_to root_path, notice: 'Successfully logged out.'
    end
end