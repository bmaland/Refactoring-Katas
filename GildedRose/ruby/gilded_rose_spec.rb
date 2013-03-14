require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe '#update_quality' do
    let(:items) do
      [Item.new('foo', sell_in: 10, quality: 10)]
    end

    it 'does not change the name' do
      name = 'foo'
      items = [Item.new(name, sell_in: 0, quality: 0)]
      GildedRose.new(items).update_quality
      items[0].name.should == name
    end

    it 'lowers the sell in of all items' do
      old_items = items.map(&:sell_in)
      GildedRose.new(items).update_quality
      items.each_with_index do |item, i|
        item.sell_in.should < old_items[i]
      end
    end

    # It's so pretty ;_;
    it 'lowers the quality of all items' do
      old_items = items.map(&:quality)
      GildedRose.new(items).update_quality
      items.each_with_index do |item, i|
        item.quality.should < old_items[i]
      end
    end

    context 'when an item has 0 quality' do
      let(:items) { [Item.new('name', sell_in: 0, quality: 0)] }

      it 'should never become negative' do
        GildedRose.new(items).update_quality
        items.first.quality.should == 0
      end
    end

    context 'when the sell by date has passed' do

      let(:items) { [Item.new('name', sell_in: 0, quality: 4)] }

      it 'degrades quality twice as fast' do
        GildedRose.new(items).update_quality
        items.first.quality.should == 2
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
