class Camera
  def initialize(world, tile_data)
    @world = world
    @tile_data = tile_data
    @position_x = @position_y = 0
  end

  def set_viewport(width, height)
    @viewport_width = width
    @viewport_height = height
  end

  def set_transform(x, y)
    @transform_x = x
    @transform_y = y
  end

  def focus(physic_body)
    @focused_body = physic_body
  end

  def draw_tiles(zorder)
    position_x = @focused_body.p.x.floor + @transform_x
    position_y = @focused_body.p.y.floor + @transform_y

    offset_x = position_x % Block::width
    offset_y = position_y % Block::height

    (0..@viewport_width).step(Block::width).each do |x|
      (0..@viewport_height).step(Block::height).each do |y|
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

  def draw_actors(actors)
    actors.each do |actor|
      relative_x = -@focused_body.p.x+@viewport_width/2
      relative_y = -@focused_body.p.y+@viewport_height/2
      actor.draw(relative_x, relative_y)
    end
  end
end