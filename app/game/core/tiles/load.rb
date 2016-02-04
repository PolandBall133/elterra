require 'json'
require 'gosu'

module Tiles
  def self.load_tiles_json(path)
    data_hash = JSON.parse(File.read(path))
  end

  def self.load_tiles(dirpath)
    data_hash = load_tiles_json(dirpath+"/tilemap.json")
    name_binded_tile_images = Hash[data_hash['tiles'].map{
        |tilename, tilepath| [tilename.intern, Gosu::Image.new(dirpath+"/"+tilepath, :tileable => true)]
    }]
  end
end