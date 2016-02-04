class TileData
  class TileDataElement
    attr_reader :symbol, :image
    def initialize(sym, image)
      @symbol = sym
      @image = image
    end
  end
  attr_accessor :tiles, :ids
  def initialize(tiles)
    @tiles = tiles

    @ids = tiles.map{ |k, image| TileDataElement.new(k, image) }
  end
end
