class ArtworkSharesController < ApplicationController

    def create
        artwork_share = ArtworkShare.new(self.artwork_share_params)
        if artwork_share.save
            render json: artwork_share
        else
            reder json: artwork_share.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy 
        if share = ArtworkShare.destroy(params[:id])
            share.destroy
            render json: share
        else
            render plain: "Artwork #{artwork_share_params[:artwork_id]} is not shared with user #{artwork_share_params[:viewer_id]}"  
        end 
    end


    protected
    def artwork_share_params
        params.require(:artwork_shares).permit(:artwork_id, :viewer_id) 
    end
end