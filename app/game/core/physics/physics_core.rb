require './game/core/world/block'
class PhysicsCore
  GRAVITY = 0.0001
  SUBSTEPS = 5

  attr_accessor :space
  def initialize
    @space = CP::Space.new
    @space.gravity = CP::Vec2.new(0, GRAVITY)
  end

  def zero_falling_of(body)
    if body.v.y > 0
      body.p.y -= body.p.y.floor % Block::height
      body.v.y = 0
    end
  end

  def test_solid(x, y)
    trans_pos_x = (x/Block::width).floor
    trans_pos_y = (y/Block::height).floor
    return unless @world.in_bounds? trans_pos_x, trans_pos_y
    @tile_data.ids[@world.block_at(trans_pos_x, trans_pos_y).id].is_solid
  end

  def touching_ground?(body)
    test_solid(body.p.x, body.p.y)
  end

  def zero_left_movement_of(body)
    if(body.v.x < 0)
      body.v.x = 0.0
    end
  end

  def zero_right_movement_of(body)
    if(body.v.x > 0)
      body.v.x = 0.0
    end
  end

  def touching_left?(body, width)
    test_solid(body.p.x-1, body.p.y-1)
  end

  def touching_right?(body, width)
    test_solid(body.p.x+1, body.p.y-1)
  end

  def update(world, tile_data, actors, dt)
    @world = world
    @tile_data = tile_data

    SUBSTEPS.times do
      actors.each do |actor|
        attrs = actor.physical_attributes
        body = attrs.body
        zero_falling_of body if touching_ground? body
        zero_left_movement_of body if touching_left? body, actor.width
        zero_right_movement_of body if touching_right? body, actor.width
        attrs.shape.body.reset_forces
      end
      @space.step(dt)
    end
  end
end