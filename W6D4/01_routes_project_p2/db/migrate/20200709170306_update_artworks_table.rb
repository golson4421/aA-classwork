class UpdateArtworksTable < ActiveRecord::Migration[5.2]
  def change
    remove_index :artwork_shares, name: "index_artwork_shares_on_artwork_id"
    add_index :artwork_shares, [:artwork_id, :viewer_id], unique: true
    remove_index :artworks, name: "index_artworks_on_artist_id"
    add_index :artworks, :title, unique: true
  end
end
