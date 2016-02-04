require 'gosu'

require './game/core/tiles/load'
require './game/core/tiles/tile_data'

module ZOrder
  BACKGROUND, STARS, PLAYER, USER_INTERFACE = *0..3
end

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = 'Elterra'

    @tile_data = TileData.new(Tiles.load_tiles('media/tiles'))
  end

  def update
  end

  def draw
    @tile_data.ids[0].image.draw(0, 0, 1)
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

window = GameWindow.new
window.show