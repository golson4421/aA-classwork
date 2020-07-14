class SessionsController < ApplicationController

    def new
        render :new
    end

    def create
        user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        if user
            login!(user)
        else
            render :new
        end
    end

    def destroy
        # worry about this in the next section
    end

end