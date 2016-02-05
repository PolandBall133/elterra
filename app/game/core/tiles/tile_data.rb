class TileData
  class TileDataElement
    attr_reader :symbol, :image, :is_solid
    def initialize(sym, image, is_solid)
      @symbol = sym
      @image = image
      @is_solid = is_solid
    end
  end
  attr_accessor :tiles, :ids
  def initialize(tiles)
    @tiles = tiles

    @ids = tiles.map{ |k, data| TileDataElement.new(k, data[0], data[1]) }
  end
end
