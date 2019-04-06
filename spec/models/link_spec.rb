require 'rails_helper'

RSpec.describe Link, type: :model do
  before do
    @link = Link.new(url: 'http://example.com/1', title: 'test', rate: 0)
  end
  context "when created from rake job" do
    it "should have url" do
      expect(@link.url).to_not be_empty
    end
    it "should have title" do
      expect(@link.url).to_not be_empty
    end
    it "should have rate" do
      expect(@link.rate).to_not be_nil
    end
    it "rate should eq to 0" do
      expect(@link.rate).to eq(0)
    end
  end
end
