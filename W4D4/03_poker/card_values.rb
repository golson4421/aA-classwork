module CardValues

    SUITS = [ "♣︎", "♦︎", "♥︎", "♠︎" ]

    VALUES = {
        2=>"2", 3=>"3", 4=>"4", 5=>"5", 6=>"6", 7=>"7", 8=>"8",
        9=>"9", 10=>"10", 11=>"J", 12=>"Q", 13=>"K", 14=>"A"
    }

    HANDS = {
        high_card?:0,
        one_pair?:1,
        two_pair?:2,
        three_of_a_kind?:3,
        straight?:4,
        flush?:5,
        full_house?:6,
        four_of_a_kind?:7,
        straight_flush?:8
    }



end