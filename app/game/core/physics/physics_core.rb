require './game/core/world/block'
require './game/core/physics/world_tests'

class PhysicsCore
  GRAVITY = 0.000_1
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

  def zero_rising_of(body)
    if body.v.y < 0
      body.v.y = 0
    end
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



  def update(world, tile_data, actors, dt)
    @world = world
    @world_test = WorldTests.new(world, tile_data)
    @tile_data = tile_data

    SUBSTEPS.times do
      actors.each do |actor|
        attrs = actor.physical_attributes
        body = attrs.body
        zero_falling_of body if @world_test.touching_ground? body, actor.width
        zero_rising_of body if @world_test.touching_ceil? body, actor.width
        zero_left_movement_of body if @world_test.touching_left? body, actor.width
        zero_right_movement_of body if @world_test.touching_right? body, actor.width
        attrs.shape.body.reset_forces
      end
      @space.step(dt)
    end
  end
end