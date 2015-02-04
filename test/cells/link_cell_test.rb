require 'test_helper'

class LinkCellTest < Cell::TestCase
  test "item" do
    invoke :item
    assert_select "p"
  end
  

end
