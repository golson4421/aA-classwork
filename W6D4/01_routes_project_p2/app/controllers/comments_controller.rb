class CommentsController < ApplicationController

    def index
        if params[:user_id] && params[:artwork_id]
            render json: Comment.where(user_id: params[:user_id]).where(artwork_id: params[:artwork_id])
        elsif params[:user_id] 
            #index on artwork_id code
            render json: Comment.where(user_id: params[:user_id])
        elsif params[:artwork_id]
            #index on user_id code
            render json: Comment.where(artwork_id: params[:artwork_id])
        else
            render :text => "Not Found", :status => 404 
        end
    end 

    def create 
        comment = Comment.create(self.comment_params)
        if comment.save 
            render json: comment 
        else  
            render json: comment.errors.full_messages, status: :unprocessable_entity
        end 
    end 

    destroy
        if comment = Comment.destroy(params[:id])
            comment.destroy
            render json: comment
        else
            render plain: "Could not find comment with id #{params[:id]}"
        end
    end


    protected
    def comment_params
        params.require(:comments).permit(:user_id, :artwork_id, :body)
    end
end