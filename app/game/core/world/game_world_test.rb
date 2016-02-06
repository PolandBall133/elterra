require 'minitest/autorun'

require_relative 'game_world'
require_relative 'block'
require_relative 'wall'

describe GameWorld do
  before do
    width = 5
    height = 5
    blocks = [Block.new(0)]*width*height
    walls = [Wall.new(0)]*width*height

    @world = GameWorld.new(width, height, blocks, walls)
  end

  describe '#empty instance' do
    world = GameWorld.new(0, 0, [], [])

    it 'has zero width' do
      assert_equal 0, world.width
    end

    it 'has zero height' do
      assert_equal 0, world.height
    end
  end

  describe '#in_bounds checks' do

    it 'first element is in bounds' do
      assert_equal true, @world.in_bounds?(0, 0)
    end

    it 'element before the first one is not in bounds' do
      assert_equal false, @world.in_bounds?(-1, 0)
      assert_equal false, @world.in_bounds?(0, -1)
      assert_equal false, @world.in_bounds?(-1, -1)
    end

    it 'last element is in bounds' do
      assert_equal true, @world.in_bounds?(@world.width-1, @world.height-1)
    end

    it 'element after the last the last one is not in bounds' do
      max_x, max_y = @world.width-1, @world.height-1
      assert_equal false, @world.in_bounds?(max_x+1, max_y)
      assert_equal false, @world.in_bounds?(max_x, max_y+1)
      assert_equal false, @world.in_bounds?(max_x+1, max_y+1)
    end
  end

  describe '#blocks access' do
    it 'first block is a valid block' do
      assert_instance_of Block, @world.block_at(0, 0)
    end

    it 'last block is a valid block' do
      assert_instance_of Block, @world.block_at(@world.width-1, @world.height-1)
    end
  end

  describe '#walls access' do
    it 'first wall is a valid wall' do
      assert_instance_of Wall, @world.wall_at(0, 0)
    end

    it 'last wall is a valid wall' do
      assert_instance_of Wall, @world.wall_at(@world.width-1, @world.height-1)
    end
  end
end