require "spec_helper"

describe Frakzio do
  it "should be valid with assigned standard fraction" do
    item = Item.new(:width => "5 5/7")
    item.valid?.should == true
  end
  
  it "should be valid with assigned string/decimal value" do
    item = Item.new(:width => "10.7")
    item.valid?.should == true
  end
  
  it "should be valid with assigned decimal value" do
    item = Item.new(:width => 0.7)
    item.valid?.should == true
  end
  
  it "should be valid with assigned integer value" do
    item = Item.new(:width => 5)
    item.valid?.should == true
  end
  
  it "shouldn't be valid with assigned alpha type string" do
    item = Item.new(:width => "dsadsadas")
    item.valid?.should == false
  end

  it "shouldn't be valid with assigned alpha type string" do
    item = Item.new(:width => "..........")
    item.valid?.should == false
  end
  
  it "shouldn't be valid with numeric/dot type string" do
    item = Item.new(:width => "10.01.01")
    item.valid?.should == false
  end
  
  it "shouldn't be valid with numeric/slash like string" do
    item = Item.new(:width => "10 3/6/8")
    item.valid?.should == false
  end

  it "should assign a float and return fraction string representation" do
    item = Item.create(:width => 10.8)
    item.width.should == "10 4/5"
  end

  it "should assign a float like string and return the fraction string representation" do
    item = Item.create(:width => "10.6")
    item.width.should == "10 3/5"
  end
  
  it "should assign a regular fraction string and return the fraction string representation" do
    item = Item.create(:width => "10 24/12")
    item.width.should == "12"
  end
  
  it "should assign a regular fraction string and return the fraction string representation" do
    item = Item.create(:width => "100/12")
    item.width.should == "8 1/3"
  end
end