require_relative 'super_useful'

puts "'five' == #{convert_to_int('five')}"

feed_me_a_fruit



begin
    sam = BestFriend.new('', 1, '')
    sam.talk_about_friendship
    sam.do_friendstuff
    sam.give_friendship_bracelet
rescue
    bob = BestFriend.new('Bob', 5, '')
    bob.talk_about_friendship
    bob.do_friendstuff
    bob.give_friendship_bracelet
ensure
    larry = BestFriend.new('Larry', 10, 'golfing')
    larry.talk_about_friendship
    larry.do_friendstuff
    larry.give_friendship_bracelet
end