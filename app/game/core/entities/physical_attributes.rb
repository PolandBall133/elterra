require 'chipmunk'

def quad_shape(body, width, height, offset = CP::Vec2.new(0,0))
  shape_verts = [CP::Vec2.new(-width, height), CP::Vec2.new(width, height),
                 CP::Vec2.new(width, -height), CP::Vec2.new(-width, -height), ]
  CP::Shape::Poly.new(body, shape_verts, offset)
end

class PhysicalAttributes
  attr_accessor :body, :shape
  def initialize(space, physical_body, physical_shape)
    @body = physical_body
    @shape = physical_shape

    space.add_body(@body)
    space.add_shape(@shape)
  end
end