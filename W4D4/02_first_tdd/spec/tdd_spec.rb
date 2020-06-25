require "tdd"

describe Array do

  describe '#my_uniq' do
    subject(:array) { [1, 2, 1, 3, 3] }
    context 'returns only unique elements from the array' do
        it 'returns a new array' do
          expect(array.my_uniq).to be_a(Array)
        end
        it 'removes elements from an array with duplicates' do
          expect(array.my_uniq).to eq(array.uniq)
        end
        it 'returns unique elements in original order' do
          sorted_uniq = array.my_uniq.sort_by { |ele| array.index(ele) }
          expect(array.my_uniq).to eq(sorted_uniq)
        end
        it 'does not remove elements from an array without duplicates' do
            expect([1,2,3].my_uniq).to eq([1,2,3])
        end
        it 'it does not modify the original array' do
            expect(array.my_uniq).to_not be(array)
        end
    end
  end

  describe '#two_sum' do
    subject(:array) { [-1, 0, 2, -2, 1] }
    context 'finds all pairs of positions where the elements at those positions sum to zero' do
      it 'finds all pairs' do
        expect(array.two_sum).to include([0, 4])
        expect(array.two_sum).to include([2, 3])
      end
      it 'all pairs are sorted by their index in ascending order' do
        expect(array.two_sum).to eq([[0, 4], [2, 3]])
        expect(array.two_sum).to_not eq([[2, 3], [0, 4]])
      end
   end
  end

  describe '#my_transpose' do
    matrix = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
    ]
    context 'convert positions of rows & columns in a square 2-D array (matrix)' do
        it 'does not alter the original matrix size' do
          new_matrix = matrix.my_transpose
          expect(matrix).to be(matrix)
          expect(matrix).to eq(matrix)
        end
        it 'transposes the matrix' do
          expect(matrix.my_transpose).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
        end
        it 'can handle data type for the elements' do
          expect{ [[:g, :b],[:p, :y]].my_transpose }.to_not raise_error()
        end
        it 'only accepts a square matrix (length & width equal to one another)' do
          expect{[[:g, :b],[:p, :y, :r]].my_transpose}.to raise_error(ArgumentError)
        end
    end
  end

end

describe "stock_picker" do
  subject(:stock_prices) { [5, 2, 7, 3, 8, 2, 8] }
  context "picks most profitable days to buy and sell stock" do
    it "finds the most profitable days" do
        expect(stock_picker(stock_prices)).to eq([1,4]).or eq([5,6])
    end
    it "only returns a singular pair" do
        expect(stock_picker(stock_prices).length).to eq(2)
    end
    it "enforces the buy before selling criteria" do
        result = stock_picker(stock_prices)
        expect(result[1] - result[0]).to be > 0
    end
    it "in the event of a tie, chooses the later buying date" do
        expect(stock_picker(stock_prices)).to eq([5,6])
    end
  end
end

describe TowersOfHanoi do
    subject(:game) { TowersOfHanoi.new }
    describe "#initialize" do
        context "instantiates the game with three arrays" do
            it "tower one (towers[0]) represents the stack, the other two are empty" do
                expect(game.towers).to eq([[1,2,3],[],[]])
            end
        end
        context "starts the game and instantiates remaining tries with a starting number of 10" do
            it "remaining tries is accessible and equal to 10" do
                expect{ game.remaining_tries }.to_not raise_error
                expect(game.remaining_tries).to be(10)
            end
            it "won? is instantiated to false" do
                expect(game.won?).to be false
            end
        end
    end

    describe "#move" do

        it "move receives two indices— the starting peg and ending peg" do
          expect { game.move(1, 3)}.to_not raise_error(ArgumentError)
        end
        it "does not allow user to select out-of-range pegs" do
          expect { game.move(1, 4) }.to raise_error(ArgumentError)
        end
        it "does not allow user to select a starting peg that's currently empty" do
          expect{game.move(2, 3)}.to raise_error(ArgumentError) # [[1],[2],[3]]
        end
        it "does not allow user to place a larger disk on top of a smaller one" do
          game.towers = [[1],[2],[3]]
          expect{ game.move(3, 1) }.to raise_error(ArgumentError)
        end
        it "moves disks according to valid user input" do
          game.towers = [[1],[2],[3]]
          game.move(1, 3)
          expect(game.towers).to eq([[],[2],[1, 3]])
        end
    end

    describe "#won?" do
        it "returns true if one of pegs two and three contains all elements, with the other two empty" do
            game.towers = [[],[1,2,3],[]]
            expect(game.won?).to be true
        end
        it "returns false if number of turns expires before disks are sorted on peg two or three" do
            game.towers = [[],[2,3],[1]] ; game.remaining_tries = 0
            expect(game.won?).to be false
        end
    end

end