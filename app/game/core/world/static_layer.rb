module PredefStaticLayers
  WALLS = 0
  BLOCKS = 1
end

class StaticLayer
  attr_reader :width, :height

  def initialize(width, height, data)
    @width = width
    @height = height
    @data = data
  end

  def translate_position(xpos, ypos)
    xpos*@height+ypos
  end

  def data_at(x, y)
    @data[translate_position(x, y)]
  end
  alias_method :at, :data_at

  def set_data_at(x, y, value)
    @data[translate_position(x, y)] = value
  end
  alias_method :set_at, :set_data_at
end