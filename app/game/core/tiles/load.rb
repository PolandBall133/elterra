require 'json'
require 'gosu'

module Tiles
  def self.load_tiles_json(path)
    data_hash = JSON.parse(File.read(path))
  end

  def self.load_tiles(dirpath)
    data_hash = load_tiles_json(dirpath+'/tilemap.json')
    name_binded_tile_images = Hash[data_hash['tiles'].map{
      |block_name, block_data| [
          block_name.intern,
          [Gosu::Image.new(dirpath+'/'+block_data['image_path'], :tileable => true), block_data['is_solid']]
      ]
    }]
  end
end