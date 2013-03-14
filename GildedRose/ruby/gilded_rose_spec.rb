require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe '#update_quality' do
    let(:items) do
      [Item.new('foo', sell_in: 10, quality: 10)]
    end

    it 'does not change the name' do
      name = 'foo'
      items = [Item.new(name, sell_in: 0, quality: 0)]
      GildedRose.new(items).update_quality()
      items[0].name.should == name
    end

    it 'lowers the sell in values of all items' do
      items.each do |item|
        old = item.sell_in
        GildedRose.new(items).update_quality()
        item.sell_in.should < old
      end
    end

  end

end

describe Item do
  it 'should have a name, sell in and a quality' do
    item = Item.new('brie', sell_in: 1, quality: 2)
    item.name.should == 'brie'
    item.sell_in.should == 1
    item.quality.should == 2
  end
end
