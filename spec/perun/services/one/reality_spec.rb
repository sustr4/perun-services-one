require "spec_helper"

describe Perun::Services::One::Reality do
  context "#makeGroupIndex" do
    it "returns proper array"
      
  end

  context ".randomPassword" do
    it "at least produces a string" do
      expect(Perun::Services::One::Reality.randomPassword).to be_an_instance_of(String)
    end

    it "returns non-empty" do
      expect(Perun::Services::One::Reality.randomPassword.length).to be > 1
    end
  end
end
