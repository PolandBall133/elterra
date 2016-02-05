class GameWorld
  attr_accessor :blocks
  attr_reader :width, :height
  def initialize(width, height, blocks)
    @width = width
    @height = height
    @blocks = blocks
  end

  def translate_position(xpos, ypos)
    xpos*@height+ypos
  end

  def block_at(xpos, ypos)
    @blocks[translate_position(xpos, ypos)]
  end

  def set_block_at(xpos, ypos, val)
    @blocks[translate_position(xpos, ypos)] = val
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