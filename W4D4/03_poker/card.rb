require_relative "card_values"
require "colorize"

class Card
    attr_reader :suit, :value
    include CardValues

    def initialize(suit, value)
        @suit = suit
        @value = value
        @color = (suit == "♥︎" || suit == "♦︎") ? :red : :black
    end

    def inspect
        "#{@suit.colorize(@color)}#{VALUES[@value].colorize(@color)}"
    end
end