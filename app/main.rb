require 'gosu'

require './game/core/tiles/load'
require './game/core/tiles/tile_data'
require './game/core/world/game_world'
require '../app/game/core/world/block'
require '../app/game/core/camera/camera'

module ZOrder
  BACKGROUND, TILES, USER_INTERFACE = *0..2
end

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = 'Elterra'

    @tile_data = TileData.new(Tiles.load_tiles('media/tiles'))
    @world = GameWorld.new(40, 40, Array.new(40*40, Block.new(1)))
    @world.set_block_at(0, 0, Block.new(0))
    @world.set_block_at(10, 10, Block.new(0))
    @camera = Camera.new(@world, @tile_data)
  end

  def update
    if(mouse_x)
      @camera.position_x = mouse_x.round
    end
    if(mouse_y)
      @camera.position_y = mouse_y.round
    end
    # || 0
    #|| 0
  end

  def draw
    @camera.draw(ZOrder::TILES, width, height)
  end

  def needs_cursor?
    true
  end
end

window = GameWindow.new
window.show