require_relative "spec_helper"

describe "tests" do
  it "Should run some tests" do
    true.must_equal false
  end
  
  it "Should have access to stuff from market.rb" do
    DAN_CONSTANT.must_equal 42
  end
  
end
