require 'gosu'

class Camera
  attr_accessor :position_x, :position_y
  def initialize(world, tile_data)
    @world = world
    @tile_data = tile_data
    @position_x = @position_y = 0
  end

  def draw(zorder, screen_width, screen_height)
    trans_width_halved = (screen_width / Block::width) / 2
    trans_height_halved = (screen_height / Block::height) / 2

    trans_y = position_y / Block::height
    trans_x = position_x / Block::width

    begin_y = trans_y-trans_height_halved
    begin_x = trans_x-trans_width_halved

    end_y = trans_y+trans_height_halved
    end_x = trans_x+trans_width_halved

    begin_y.upto end_y do |y|
      begin_x.upto end_x do |x|
        if y >= 0 && x >= 0 && y < @world.height && x < @world.width
          block = @world.block_at(x, y)
          @tile_data.ids[block.id].image.draw(position_x+x*Block::width, position_y+y*Block::height, zorder)
        end
      end
    end
  end

end