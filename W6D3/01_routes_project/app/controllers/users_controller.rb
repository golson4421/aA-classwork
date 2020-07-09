class UsersController < ApplicationController

    def index
        render json: User.all
    end

    def create
        user = User.new(params.require(:user).permit(:name, :email))
        # replace the `user_attributes_here` with the actual attribute keys
        if user.save
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        begin user = User.find(params[:id])
            render json: user
        rescue
            render plain: "Couldn't find User with 'id'=#{params[:id]}"
        end
        
    end

    def destroy
        begin User.destroy(params[:id])
            render plain: "User #{params[:id]} has been destroyed"
        rescue
            render plain: "Couldn't find User with 'id'=#{params[:id]}"
        end
    end

    def update
        begin user = User.find(params[:id])
            user.update(params.require(:user).permit(:name, :email))
            render json: user
        rescue
            render plain: "Couldn't find User with 'id'=#{params[:id]}, creating a new user"
            self.create 
            # render plain: "Couldn't find User with 'id'=#{params[:id]}"
        end
    end

end