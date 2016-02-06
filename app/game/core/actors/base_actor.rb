class BaseActor
  attr_accessor :physical_attributes
  attr_reader :width, :height, :zorder

  def initialize(space, x, y, image, zorder)
    body = CP::Body.new(x, y)
    shape = quad_shape(body, image.width, image.height)
    @physical_attributes = PhysicalAttributes.new(space, body, shape)
    @image = image
    @width = image.width
    @height = image.height
    @zorder = zorder
  end

  def lerp_horizontally_to(val, denominator)
    @physical_attributes.body.v.x = @physical_attributes.body.v.lerpconst(CP::Vec2.new(val, 0), @vx/denominator).x
  end

  def draw(x, y)
    @image.draw(physical_attributes.body.p.x+x-@image.width/2, physical_attributes.body.p.y+y-@image.height, @zorder)
  end
end