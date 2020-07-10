class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id, null:false
      t.index :user_id 
      t.integer :artwork_id, null:false
      t.index :artwork_id 
      t.string :body 
    end
  end
end
