class WorldTests
  COLLISION_EPSILON = 1
  def initialize(world, tile_data)
    @world = world
    @tile_data = tile_data
  end
  #todo: use collision matrix for testing

  def test_solid(x, y)
    trans_pos_x = (x/Block::width).floor
    trans_pos_y = (y/Block::height).floor
    return unless @world.in_bounds? trans_pos_x, trans_pos_y
    @tile_data.ids[@world.block_at(trans_pos_x, trans_pos_y).id].is_solid
  end

  def touching_ground?(body, width)
    left = test_solid(body.p.x-width/2+COLLISION_EPSILON, body.p.y)
    right = test_solid(body.p.x+width/2-COLLISION_EPSILON, body.p.y)
    left or right
  end

  def touching_ceil?(body, width)
    left = test_solid(body.p.x-width/2+COLLISION_EPSILON*4, body.p.y-Block::width)
    middle = test_solid(body.p.x, body.p.y-Block::width)
    right = test_solid(body.p.x+width/2-COLLISION_EPSILON*4, body.p.y-Block::width)
    left or middle or right
  end

  def touching_left?(body, width)
    test_solid(body.p.x-width/2, body.p.y-1)
  end

  def touching_right?(body, width)
    test_solid(body.p.x+width/2, body.p.y-1)
  end
end