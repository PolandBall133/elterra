class Block
  attr_reader :id
  def initialize(id)
    @id = id
  end

  def self.width
    32
  end

  def self.height
    32
  end
end