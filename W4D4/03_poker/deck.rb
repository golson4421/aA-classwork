require_relative "card"
require_relative "card_values"

class Deck
    attr_accessor :shuffled_deck
    include CardValues

    def initialize
        @shuffled_deck = self.shuffle_deck
    end

    def shuffle_deck
        empty_deck = []
        SUITS.each do |suit|
            VALUES.keys.each do |value|
                empty_deck.push(Card.new(suit, value))
            end
        end
        empty_deck.shuffle!
    end

    def count
        @shuffled_deck.count
    end






end