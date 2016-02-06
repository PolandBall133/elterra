require './game/core/entities/physical_attributes'
require './game/core/world/block'
require './game/core/world/wall'
require './game/core/actors/base_actor'
require 'gosu'

class Player < BaseActor
  def initialize(world, space, zorder, x, y)
    image = Gosu::Image.new('media/util/test_player.bmp', :tileable => false)
    super(space, x, y, image, zorder)

    @vx = 0.09
    @world = world
  end

  def handle_input(input)
    lerp_horizontally_to 0, 6
    if input.button_down? Gosu::KbA
      lerp_horizontally_to -@vx, 4
    end
    if input.button_down? Gosu::KbD
      lerp_horizontally_to @vx, 4
    end

    if input.button_down? Gosu::KbSpace
      @physical_attributes.body.v.y = -0.1
    end

    (Gosu::Kb1..Gosu::Kb7).each do |digit_key|
      if input.button_down? digit_key
        x = ((physical_attributes.body.p.x+input.mouse_x-input.width/2)/Block::width).floor
        y = ((physical_attributes.body.p.y+input.mouse_y-input.height/2)/Block::height).floor
        id = digit_key-Gosu::Kb1
        if @world.in_bounds? x, y
          if input.button_down? Gosu::Kb0
            @world.set_wall_at(x, y, Wall.new(id))
          else
            @world.set_block_at(x, y, Block.new(id))
          end
        end
      end
    end
  end
end