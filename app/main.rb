require 'gosu'

require './game/core/layers/load'
require './game/core/layers/tile_data'

require './game/core/layers/wall_data'

require './game/core/world/game_world'
require './game/core/world/block'
require './game/core/world/wall'

require './game/core/camera/camera'

require './game/core/actors/player'

require './game/core/physics/physics_core'

module ZOrder
  BACKGROUND, TILES, WALLS, PLAYER, USER_INTERFACE = *0..4
end

class GameWindow < Gosu::Window
  attr_reader :world
  def initialize
    super 640, 480
    self.caption = 'Elterra'

    @tile_data = TileData.new(Tiles.load_tiles('media/tiles'))
    @wall_data = WallData.new(Walls.load_walls('media/walls'))

    @save_file = 'saves/last_game.elsave'
    @save_file = ARGV[0] if !ARGV[0].nil?
    @world = GameWorld.load(@save_file)

    @physics = PhysicsCore.new

    @player = Player.new(@world, @physics.space, ZOrder::PLAYER, 10, 10)
    @actors = [@player]

    @camera = Camera.new(@world, @tile_data, @wall_data)
    @camera.set_viewport(width, height)
    @camera.set_transform(-width/2, -height/2)

    @camera.focus(@player.physical_attributes.body)
  end

  def update
    @player.handle_input(self)

    @physics.update(@world, @tile_data, @actors, update_interval)
  end

  def draw
    @camera.draw(ZOrder::WALLS, ZOrder::TILES)
    @camera.draw_actors(@actors)
  end

  def needs_cursor?
    true
  end
end

window = GameWindow.new
window.show

window.world.save("saves/last_game.elsave")
