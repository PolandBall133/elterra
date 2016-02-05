class Camera
  attr_accessor :position_x, :position_y
  def initialize(world, tile_data)
    @world = world
    @tile_data = tile_data
    @position_x = @position_y = 0
  end

  def draw(zorder, screen_width, screen_height)
    offset_x = position_x % Block::width
    offset_y = position_y % Block::height

    (0..screen_width).step(Block::width).each do |x|
      (0..screen_height).step(Block::height).each do |y|
        trans_x = x+position_x
        trans_y = y+position_y
        next if trans_x < 0 || trans_y < 0 || trans_x >= @world.width*Block::width || trans_y >= @world.height*Block::height

        block = @world.block_at(trans_x/Block::width, trans_y/Block::height)
        block_x = x - offset_x
        block_y = y - offset_y

        @tile_data.ids[block.id].image.draw(block_x, block_y, zorder)
      end
    end
  end
end