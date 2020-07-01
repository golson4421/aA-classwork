require_relative "card"
require_relative "card_values"
require_relative "deck"

class Hand
    attr_reader :hand, :values_held, :suits_held
    include CardValues

    def initialize(deck)
        @deck = deck
        @hand = self.deal_hand(@deck)
        @values_held = self.hand.map(&:value)
        @suits_held = self.hand.map(&:suit)
    end

    def inspect
        "#{@hand}"
    end
    
    def deal_hand(deck)
        empty_hand = []
        5.times { empty_hand << deck.shuffled_deck.pop }
        empty_hand
    end

    def draw_cards(deck)
        until @hand.length == 5
            @hand << deck.shuffled_deck.pop
        end
        @hand
    end

    def discard(idx)
        @hand.delete_at(idx)
        @hand
    end

    def how_many_of_a_kind
        counts = Hash.new(0)
        self.values_held.each { |val| counts[val] += 1 }
        counts
    end
    
    def high_card?
        true
    end
    
    def one_pair?
        self.how_many_of_a_kind.any? { |k,v| v >= 2 }
    end
    
    def two_pair?
        self.how_many_of_a_kind.count { |k,v| v >= 2 } == 2
    end
    
    def three_of_a_kind?
        self.how_many_of_a_kind.any? { |k,v| v == 3  }
    end

    def straight?
        mapped_vals = self.values_held
        min_held = mapped_vals.min ; max_held = mapped_vals.max
        mapped_vals.sort == (min_held..max_held).to_a
    end

    def flush?
        self.suits_held.uniq.length == 1
    end

    def full_house?
        self.how_many_of_a_kind.values.sort == [2,3]
    end

    def four_of_a_kind?
        self.how_many_of_a_kind.any? { |k,v| v == 4  }
    end

    def straight_flush?
        self.straight? && self.flush?
    end

    def best_rank
        hand_ranks = HANDS.select { |method,rank| self.send(method) }
        hand_ranks.values.max
    end

    def winner?(other_hand)
        case self.best_rank <=> other_hand.best_rank
        when 1
            return true
        when -1
            return false
        when 0
            self.break_tie(other_hand)
        end
    end

    def highest_card
        self.values_held.max
    end

    def highest_pair
        pairs = self.how_many_of_a_kind.select { |k,v| v == 2 }
        pairs.keys.max
    end

    def highest_trip
        trips = self.how_many_of_a_kind.select { |k,v| v == 3 }
        trips.keys.max
    end

    def highest_quad
        quads = self.how_many_of_a_kind.select { |k,v| v == 4 }
        quads.keys.max
    end


    def break_tie(other_hand)
        case self.best_rank
        when 0,4,5,8
            self.highest_card > other_hand.highest_card ? true : false
        when 1,2
            self.highest_pair > other_hand.highest_pair ? true : false
        when 3,6
            self.highest_trip > other_hand.highest_trip ? true : false
        when 7
            self.highest_quad > other_hand.highest_quad ? true : false
        end
    end

end