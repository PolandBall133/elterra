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

    @world = GameWorld.load('saves/test.elterra.save')

    @camera = Camera.new(@world, @tile_data)
  end

  def update
    if button_down? Gosu::KbLeft
      @camera.position_x -= 1
    end
    if button_down? Gosu::KbRight
      @camera.position_x += 1
    end

    if button_down? Gosu::KbUp
      @camera.position_y -= 1
    end
    if button_down? Gosu::KbDown
      @camera.position_y += 1
    end
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