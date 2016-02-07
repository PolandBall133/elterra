require 'minitest/autorun'

require_relative 'static_layer'

describe StaticLayer do
  describe '#creation of empty layer' do
    empty = StaticLayer.new(0, 0, nil)

    it 'has no width' do
      assert_equal 0, empty.width
    end

    it 'has no height' do
      assert_equal 0, empty.height
    end

    it 'has no data' do
      assert_nil empty.data
    end
  end

  describe 'layer data accessing' do
    before do
      width = height = 2
      @layer = StaticLayer.new(width, height, [*(0..width*height)])
    end

    it 'translation of the first element access gives a valid first element index' do
      idx = @layer.translate_position(0, 0)
      assert_equal 0, idx
      assert_equal 0, @layer.data[idx]
    end

    it 'translation of the last element access gives a valid last element index' do
      idx = @layer.translate_position(@layer.width-1, @layer.height-1)
      assert_equal @layer.width*@layer.height-1, idx
      assert_equal @layer.width*@layer.height-1, @layer.data[idx]
    end
  end
end