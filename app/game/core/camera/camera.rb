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

  def focus(physic_body)
    @focused_body = physic_body
  end

  def draw_tiles(zorder)
    position_x = @focused_body.p.x.floor
    position_y = @focused_body.p.y.floor

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
      actor.draw(@viewport_width/2, @viewport_height/2)
    end
  end
end