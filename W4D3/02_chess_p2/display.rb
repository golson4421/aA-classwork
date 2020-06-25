require_relative "cursor"
require_relative "board"
require "colorize"

class Display
    attr_accessor :cursor

    def initialize
        @board = Board.new
        @cursor = Cursor.new([0,0], @board)
    end


    def render
        @board.rows.each_with_index do |row,i|
            mapped_row = row.map.with_index do |piece,j|
                if (i+j).even?
                    piece.symbol.colorize(piece.color).on_light_black
                else
                    piece.symbol.colorize(piece.color).on_light_red
                end
            end.join("".on_light_black)
            puts mapped_row
        end
        return
    end
    
    
end


    display = Display.new
    10.times do
        display.render
        display.cursor.get_input
    end


