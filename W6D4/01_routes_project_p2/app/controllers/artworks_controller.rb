class ArtworksController < ApplicationController

    def index
        # params[:user_id]
        artworks_owned = Artwork.where(artist_id: params[:user_id]).pluck(:id)
        artworks_shared = Artwork.joins(:shared_viewers).where(artwork_shares: { viewer_id: params[:user_id] }).pluck(:id)
        all_ids = artworks_owned + artworks_shared

        # all_artworks = Artwork.joins(:shared_viewers)
        #                     .where(artist_id: params[:user_id])
        #                     .or(artwork_shares: { viewer_id: params[:user_id] })
        #                     .pluck(:id)

        render json: Artwork.where(id: all_ids)
    end

    def create
        artwork = Artwork.new(self.artwork_params)
        if artwork.save
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        if artwork = Artwork.find(params[:id]) 
            render json: artwork
        else 
            render plain: "Could not find artwork with id #{params[:id]}"
        end 
    end

    def destroy
        if artwork = Artwork.destroy(params[:id])
            artwork.destroy
            render json: artwork
        else
            render plain: "Could not find artwork with id #{params[:id]}"
        end
    end

    def update
        if artwork = Artwork.find(params[:id])
            artwork.update(self.artwork_params)
            render json: artwork
        else
            render plain: "Could not find artwork with id #{params[:id]}"
        end
    end


    protected 

    def artwork_params
        params.require(:artworks).permit(:title, :image_url, :artist_id)
    end 


end