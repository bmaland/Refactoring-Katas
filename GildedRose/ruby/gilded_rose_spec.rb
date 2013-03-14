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
      update_with([sell_in: 10, sell_in: 20]) do |item, old_item|
        item.sell_in.should < old_item.sell_in
      end
    end

    it 'lowers the quality of all items' do
      update_with([quality: 10, quality: 20]) do |item, old_item|
        item.quality.should < old_item.quality
      end
    end

    context 'when the item is an aged brie' do
      let(:name) { 'Aged Brie' }

      it 'increases quality over time' do
        update_with(name: name, quality: 0) do |item, old_item|
          item.quality.should > old_item.quality
        end
      end

      it 'never has a quality larger than 50' do
        update_with(name: name, quality: 50) do |item, old_item|
          item.quality.should == old_item.quality
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

    context 'when the item is "Sulfuras, Hand of Ragnaros"' do
      let(:name) { 'Sulfuras, Hand of Ragnaros' }

      it 'keeps its sell in and quality' do
        update_with(name: name, sell_in: 10, quality: 10) do |item, old_item|
          item.sell_in.should == old_item.sell_in
          item.quality.should == old_item.quality
        end
      end
    end

    context 'when the item is "Backstage passes to a TAFKAL80ETC concert"' do
      let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }

      it 'should increase its quality when sell_in lowers' do
        update_with(name: name, quality: 0, sell_in: 10) do |item, old_item|
          item.quality.should > old_item.quality
        end
      end

      it 'should increase its quality by 3 when sell_in is lower than 5' do
        update_with(name: name, quality: 0, sell_in: 4) do |item, old_item|
          item.quality.should == old_item.quality + 3
        end
      end

      it 'should increase its quality by 2 when sell_in is lower than 10' do
        update_with(name: name, quality: 0, sell_in: 9) do |item, old_item|
          item.quality.should == old_item.quality + 2
        end
      end

      it 'gets a quality of 0 when sell_in is 0' do
        update_with(name: name, quality: 0, sell_in: 0) do |item, old_item|
          item.quality.should == 0
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
