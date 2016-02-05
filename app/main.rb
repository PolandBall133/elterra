require 'gosu'

require './game/core/tiles/load'
require './game/core/tiles/tile_data'
require './game/core/world/game_world'
require './game/core/world/block'
require './game/core/camera/camera'
require './game/core/actors/player'

module ZOrder
  BACKGROUND, TILES, PLAYER, USER_INTERFACE = *0..3
end

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = 'Elterra'

    @tile_data = TileData.new(Tiles.load_tiles('media/tiles'))

    @world = GameWorld.load('saves/test.elterra.save')

    @player = Player.new(ZOrder::PLAYER, 10, 10)
    @actors = [@player]

    @camera = Camera.new(@world, @tile_data)
    @camera.set_viewport(width, height)

    @camera.focus(@player.physical_attributes.body)
  end

  def update
    @player.handle_input(self)

    @actors.each do |actor|
      actor.physical_attributes.body.update_position(update_interval)
    end
  end

  def draw
    @camera.draw_tiles(ZOrder::TILES)
    @camera.draw_actors(@actors)
  end

  def needs_cursor?
    true
  end
end

window = GameWindow.new
window.show