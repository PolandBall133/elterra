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
    body.v.y = 0 if body.v.y > 0
  end

  def touching_ground?(body)
    trans_pos_x = (body.p.x/Block::width).floor
    trans_pos_y = (body.p.y/Block::height).floor
    return false if trans_pos_x < 0 || trans_pos_y < 0 || trans_pos_x >= @world.width || trans_pos_y >= @world.height
    @tile_data.ids[@world.block_at(trans_pos_x, trans_pos_y).id].is_solid
  end

  def update(world, tile_data, actors, dt)
    @world = world
    @tile_data = tile_data

    SUBSTEPS.times do
      actors.each do |actor|
        attrs = actor.physical_attributes
        body = attrs.body
        zero_falling_of body if touching_ground? body

        attrs.shape.body.reset_forces
      end
      @space.step(dt)
    end
  end
end