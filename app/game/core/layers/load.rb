require 'json'
require 'gosu'

module JsonLoader
  def self.load_json(path)
    data_hash = JSON.parse(File.read(path))
  end
end
module Tiles


  def self.load_tiles(dirpath)
    data_hash = JsonLoader.load_json(dirpath+'/tilemap.json')
    name_binded_tile_images = Hash[data_hash['tiles'].map{
      |block_name, block_data| [
          block_name.intern,
          [Gosu::Image.new(dirpath+'/'+block_data['image_path'], :tileable => true), block_data['is_solid']]
      ]
    }]
  end
end

module Walls
  def self.load_walls(dirpath)
    data_hash = JsonLoader.load_json(dirpath+'/wallsmap.json')
    name_binded_tile_images = Hash[data_hash['walls'].map{
        |wall_name, wall_data| [
          wall_name.intern,
          [Gosu::Image.new(dirpath+'/'+wall_data['image_path'], :tileable => true)]
      ]
    }]
  end
end