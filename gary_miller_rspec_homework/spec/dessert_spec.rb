require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  subject(:dessert) { Dessert.new("cookie", 13, chef) }

  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq("cookie")
    end

    it "sets a quantity" do
      expect(dessert.quantity).to eq(13)
    end

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients).to eq([])
    end

    it "raises an argument error when given a non-integer quantity" do
      expect{ Dessert.new("brownie", "dozen", "sue")}.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      dessert.add_ingredient("milk")
      expect(dessert.ingredients).to eq(["milk"])
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      dessert.add_ingredient("butter")
      dessert.add_ingredient("milk")
      expect(dessert.mix!.sort).to eq(dessert.ingredients.sort)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      dessert.eat(3)
      expect(dessert.quantity).to eq(10)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect{dessert.eat(14)}.to raise_error(RuntimeError)
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef #{@name} the Great Baker")
      expect(dessert.serve).to include("Chef")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      allow(chef).to receive(:bake).and_return(400)
      expect(dessert.make_more).to eq(400)
    end
  end
end
