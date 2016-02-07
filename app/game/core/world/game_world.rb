require './game/core/world/static_layer'

class GameWorld
  attr_reader :width, :height
  def initialize(width, height, *raw_layers)
    @width = width
    @height = height

    @layers = raw_layers.map{ |data| StaticLayer.new(width, height, data) }
  end

  def blocks
    @layers[PredefStaticLayers::BLOCKS]
  end

  def walls
    @layers[PredefStaticLayers::WALLS]
  end

  def layer(id)
    @layers[id]
  end

  def translate_position(xpos, ypos)
    xpos*@height+ypos
  end

  def in_bounds?(x, y)
    not (x < 0 || y < 0 || x >= @width || y >= @height)
  end

  def self.load(path)
    game_world = Marshal.load(File.binread(path))
  end

  def save(path)
    File.open(path, 'wb') {|file| file.write(Marshal.dump(self))}
  end
end