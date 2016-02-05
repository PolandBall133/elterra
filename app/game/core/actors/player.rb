require './game/core/entities/physical_attributes'
require 'gosu'
class Player
  attr_accessor :physical_attributes

  def initialize(space, zorder, x, y)
    @image = Gosu::Image.new("media/util/test_player.bmp", :tileable => false)
    @zorder = zorder

    body = CP::Body.new(x, y)
    shape = quad_shape(body, @image.width, @image.height)
    @physical_attributes = PhysicalAttributes.new(space, body, shape)

    @vx = 0.09
  end

  def lerp_horizontal_to(val, denominator)
    @physical_attributes.body.v.x = @physical_attributes.body.v.lerpconst(CP::Vec2.new(val, 0), @vx/denominator).x
  end

  def handle_input(input)
    lerp_horizontal_to 0, 6
    if input.button_down? Gosu::KbLeft
      lerp_horizontal_to -@vx, 4
    end
    if input.button_down? Gosu::KbRight
      lerp_horizontal_to @vx, 4
    end

    if input.button_down? Gosu::KbSpace
      @physical_attributes.body.v.y = -0.1
    end
  end

  def draw(x, y)
    @image.draw(physical_attributes.body.p.x+x-@image.width/2, physical_attributes.body.p.y+y-@image.height, @zorder)
  end
end