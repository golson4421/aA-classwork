class CreateArtworkShares < ActiveRecord::Migration[5.2]
  def change
    create_table :artwork_shares do |t|
      t.integer :artwork_id, null: false
      t.index :artwork_id
      t.integer :viewer_id, null: false
      t.index :viewer_id
    end
  end
end
