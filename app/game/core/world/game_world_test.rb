require 'minitest/autorun'

require_relative 'game_world'

describe GameWorld do
  before do
    @world = GameWorld.new(2, 2, nil, nil)
  end

  describe 'GameWorld bounds check' do
    it 'first element is in bounds' do
      assert @world.in_bounds? 0, 0
    end

    it 'elements before the first elements are not in bounds' do
      assert_equal false, @world.in_bounds?(0, -1)
      assert_equal false, @world.in_bounds?(-1, 0)
      assert_equal false, @world.in_bounds?(-1, -1)
    end

    it 'last element is in bounds' do
      assert @world.in_bounds? @world.width-1, @world.height-1
    end

    it 'elements after the last element are not in bounds' do
      max_x, max_y = @world.width-1, @world.height-1
      assert_equal false, @world.in_bounds?(max_x, max_y+1)
      assert_equal false, @world.in_bounds?(max_x+1, max_y)
      assert_equal false, @world.in_bounds?(max_x+1, max_y+1)
    end
  end
end