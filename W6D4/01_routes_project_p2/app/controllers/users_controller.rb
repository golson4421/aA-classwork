class UsersController < ApplicationController

    def index(query=nil)
        query ||= params[:username] ||= ""
        users = User.where("username SIMILAR TO '%#{query}%'")
        render json: users
    end

    def create
        user = User.new(self.user_params)
        # replace the `user_attributes_here` with the actual attribute keys
        if user.save
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        user_id = params[:id]
        return self.index(user_id) unless user_id.is_a?(Integer)
        begin
            user = User.find(user_id)
            render json: user
        rescue
            render plain: "Couldn't find User with 'id'=#{params[:id]}"
            self.index
        end
        
    end

    def destroy
        if user = User.destroy(params[:id])
            user.destroy
            render json: user
        else
            render plain: "Couldn't find User with 'id'=#{params[:id]}"
        end
    end

    def update
        begin
            user = User.find(params[:id])
            user.update(self.user_params)
            render json: user
        rescue
            render plain: "Couldn't find User with 'id'=#{params[:id]}"
        end
    end
    
    protected 

    def user_params
        params.require(:user).permit(:username) 
    end 
end