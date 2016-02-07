class Camera
  def initialize(world, tile_data, wall_data)
    @world = world
    @tile_data = tile_data
    @wall_data = wall_data
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

  def draw(wall_zorder, tile_zorder)
    position_x = @focused_body.p.x.floor + @transform_x
    position_y = @focused_body.p.y.floor + @transform_y

    offset_x = position_x % Block::width
    offset_y = position_y % Block::height

    (0..@viewport_width).step(Block::width).each do |x|
      (0..@viewport_height).step(Block::height).each do |y|
        trans_x = (x+position_x) / Block::width
        trans_y = (y+position_y) / Block::height
        next unless @world.in_bounds? trans_x, trans_y

        block = @world.blocks.at(trans_x, trans_y)
        wall = @world.walls.at(trans_x, trans_y)
        final_x = x - offset_x
        final_y = y - offset_y

        @tile_data.ids[block.id].image.draw(final_x, final_y, tile_zorder)
        if block.id == 0
          @wall_data.ids[wall.id].image.draw(final_x, final_y, wall_zorder)
        end
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