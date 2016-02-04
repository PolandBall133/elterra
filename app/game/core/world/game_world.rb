class GameWorld
  attr_accessor :blocks
  attr_reader :width, :height
  def initialize(width, height, blocks)
    @width = width
    @height = height
    @blocks = blocks
  end

  def block_at(xpos, ypos)
    @blocks[xpos*@height+ypos]
  end
end