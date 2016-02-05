class WallData
  class WallDataElement
    attr_reader :symbol, :image
    def initialize(sym, data)
      @symbol = sym
      @image = data[0]
    end
  end
  attr_accessor :walls, :ids
  def initialize(walls)
    @walls = walls

    @ids = walls.map{ |k, data| WallDataElement.new(k, data) }
  end
end
