require './game/core/world/block'
class PhysicsCore
  def initialize; end

  def zero_falling_of(body)
    body.v.y = 0 if body.v.y > 0
  end

  def touching_ground?(body)
    trans_pos_x = (body.p.x/Block::width).floor
    trans_pos_y = (body.p.y/Block::height).floor
    return false if trans_pos_x < 0 || trans_pos_y < 0 || trans_pos_x >= @world.width || trans_pos_y >= @world.height
    iss = @tile_data.ids[@world.block_at(trans_pos_x, trans_pos_y).id].is_solid
    print iss if iss
    iss
  end

  def update(world, tile_data, actors, dt)
    @world = world
    @tile_data = tile_data

    actors.each do |actor|
      body = actor.physical_attributes.body
      zero_falling_of body if touching_ground? body
    end
  end
end