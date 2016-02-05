class TileData
  class TileDataElement
    attr_reader :symbol, :image, :is_solid
    def initialize(sym, data)
      @symbol = sym
      @image = data[0]
      @is_solid = data[1]
    end
  end
  attr_accessor :tiles, :ids
  def initialize(tiles)
    @tiles = tiles

    @ids = tiles.map{ |k, data| TileDataElement.new(k, data) }
  end
end
