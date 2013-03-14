require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      name = "foo"
      items = [Item.new(name, 0, 0)]
      GildedRose.new(items).update_quality()
      items[0].name.should == name
    end
  end

end
