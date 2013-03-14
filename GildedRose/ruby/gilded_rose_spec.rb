require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe '#update_quality' do
    it 'does not change the name' do
      name = 'foo'
      items = [Item.new(name, sell_in: 0, quality: 0)]
      GildedRose.new(items).update_quality()
      items[0].name.should == name
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
