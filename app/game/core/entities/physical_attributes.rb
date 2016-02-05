require 'chipmunk'

class PhysicalAttributes
  attr_accessor :body, :shape
  def initialize(physical_body, physical_shape)
    @body = physical_body
    @shape = physical_shape
  end
end