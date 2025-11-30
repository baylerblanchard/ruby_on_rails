require 'calculator'

describe Calculator do
  describe "#add" do
    it "returns the sum of two numbers" do
      # removed for brevity
    end

    # add this
    it "returns the sum of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.add(2, 5, 7)).to eql(14)
    end
  end

  describe "#multiply" do
    it "returns the product of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.multiply(2, 3, 6)).to eql(36)
    end
  end
end
