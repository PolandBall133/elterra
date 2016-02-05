require './game/core/world/block'
class PhysicsCore
  def initialize; end

  def update(world, actors, dt)
    actors.each do |actor|
      body = actor.physical_attributes.body
    end
  end
end