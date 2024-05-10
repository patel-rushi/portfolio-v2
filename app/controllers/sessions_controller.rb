class SessionsController < ApplicationController
    def login
        
    end
    
    def create
        @user = User.find_by(email: params[:email], password_digest: params[:password])
    end
end