class RemoveUniqueFromTitleArtworks < ActiveRecord::Migration[5.2]
  def change
    remove_index :artworks, name: "index_artworks_on_title"
    add_index :artworks, :title, unique: false
  end
end
