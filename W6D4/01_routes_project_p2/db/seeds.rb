# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all ; Artwork.destroy_all ; ArtworkShare.destroy_all ; Comment.destroy_all

artist1 = User.create(username: "michaelangelo")
artist2 = User.create(username: "donatello")
viewer1 = User.create(username: "tim")
viewer2 = User.create(username: "Aatef")

painting1 = Artwork.create(title: "David", image_url: "firenze.com", artist_id: artist1.id)
painting2 = Artwork.create(title: "Saint George", image_url: "google.com", artist_id: artist2.id)

as1 = ArtworkShare.create(artwork_id: painting1.id, viewer_id: viewer1.id)
as2 = ArtworkShare.create(artwork_id: painting1.id, viewer_id: artist2.id)
as3 = ArtworkShare.create(artwork_id: painting2.id, viewer_id: viewer2.id)

comment1 = Comment.create(user_id: viewer1.id, artwork_id: painting1.id, body: "THIS SUCKS")
comment2 = Comment.create(user_id: viewer2.id, artwork_id: painting2.id, body: "This doesn't suck")