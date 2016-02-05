require './game/core/entities/physical_attributes'
require './game/core/world/block'
require 'gosu'

class Player
  attr_accessor :physical_attributes
  attr_reader :width, :height
  def initialize(world, space, zorder, x, y)
    @image = Gosu::Image.new("media/util/test_player.bmp", :tileable => false)
    @width = @image.width
    @height = @image.height

    @zorder = zorder

    body = CP::Body.new(x, y)
    shape = quad_shape(body, @image.width, @image.height)
    @physical_attributes = PhysicalAttributes.new(space, body, shape)

    @vx = 0.09

    @world = world
  end

  def lerp_horizontal_to(val, denominator)
    @physical_attributes.body.v.x = @physical_attributes.body.v.lerpconst(CP::Vec2.new(val, 0), @vx/denominator).x
  end

  def handle_input(input)
    lerp_horizontal_to 0, 6
    if input.button_down? Gosu::KbA
      lerp_horizontal_to -@vx, 4
    end
    if input.button_down? Gosu::KbD
      lerp_horizontal_to @vx, 4
    end

    if input.button_down? Gosu::KbSpace
      @physical_attributes.body.v.y = -0.1
    end

    (Gosu::Kb1..Gosu::Kb6).each do |digit_key|
      if input.button_down? digit_key
        x = ((physical_attributes.body.p.x+input.mouse_x-input.width/2)/Block::width).floor
        y = ((physical_attributes.body.p.y+input.mouse_y-input.height/2)/Block::height).floor
        id = digit_key-Gosu::Kb1
        if @world.in_bounds? x, y
          @world.set_block_at(x, y, Block.new(id))
        end
      end
    end
  end

  def draw(x, y)
    @image.draw(physical_attributes.body.p.x+x-@image.width/2, physical_attributes.body.p.y+y-@image.height, @zorder)
  end
end