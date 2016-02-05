require './game/core/entities/physical_attributes'
require 'gosu'
class Player
  attr_accessor :physical_attributes

  def initialize(zorder, x, y)
    @image = Gosu::Image.new("media/util/test_player.bmp", :tileable => false)
    @zorder = zorder

    @physical_attributes = PhysicalAttributes.new(CP::Body.new(x, y), nil)
  end

  def handle_input(input)
    if input.button_down? Gosu::KbLeft
      @physical_attributes.body.v.x -= 0.01
    end
    if input.button_down? Gosu::KbRight
      @physical_attributes.body.v.x += 0.01
    end

    if input.button_down? Gosu::KbUp
      @physical_attributes.body.v.y -= 0.01
    end
    if input.button_down? Gosu::KbDown
      @physical_attributes.body.v.y += 0.01
    end
  end

  def draw(x, y)
    @image.draw(x-@image.width/2, y-@image.height/2, @zorder)
  end
end