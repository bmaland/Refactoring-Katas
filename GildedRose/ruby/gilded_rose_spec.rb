require File.join(File.dirname(__FILE__), 'gilded_rose')
require File.join(File.dirname(__FILE__), 'crap')

describe GildedRose do

  describe '#update_quality' do
    let(:items) do
      [Item.new('foo', sell_in: 10, quality: 10)]
    end

    it 'does not change the name' do
      update_with(name: 'foo') { |item| item.name.should == 'foo' }
    end

    it 'lowers the sell in of a item' do
      update_with(sell_in: 2) do |item|
        item.sell_in.should == 1
      end
    end

    it 'lowers the sell in of all items' do
      items = [sell_in: 10, sell_in: 20]
      update_with(items) do |item, i|
        item.sell_in.should < items[i][:sell_in]
      end
    end

    it 'lowers the quality of all items' do
      items = [quality: 10, quality: 20]
      update_with(items) do |item, i|
        item.quality.should < items[i][:quality]
      end
    end

    context 'when the item is an aged brie' do
      let(:name) { 'Aged Brie' }
      
      it 'increases quality over time' do
        old_quality = 0
        update_with(name: name, quality: old_quality) do |item|
          item.quality.should > old_quality
        end
      end

      it 'never has a quality larger than 50' do
        old_quality = 50
        update_with(name: name, quality: old_quality) do |item|
          item.quality.should == old_quality
        end
      end
    end

    context 'when an item has 0 quality' do
      let(:quality) { 0 }

      it 'should never become negative' do
        update_with(quality: quality) do |item|
          item.quality.should >= 0
        end
      end
    end

    context 'when the sell by date has passed' do
      let(:sell_in) { 0 }

      it 'degrades quality twice as fast' do
        update_with(quality: 4) do |item|
          item.quality.should == 2
        end
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
