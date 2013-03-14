def update_with(item_or_items)#, &blk)
  items2 = item_or_items.kind_of?(Array) ? item_or_items : [item_or_items]

  default_item_attrs = {name: 'foo', sell_in: 0, quality: 0}

  items = items2.map do |item_attrs|
    attrs = default_item_attrs.merge(item_attrs)
    name = attrs.delete(:name)
    Item.new(name, attrs)
  end

  old_items = items2.map do |item_attrs|
    attrs = default_item_attrs.merge(item_attrs)
    name = attrs.delete(:name)
    Item.new(name, attrs)
  end

  GildedRose.new(items).update_quality

  items.each_with_index { |item, i| yield item, old_items[i], i }
end
