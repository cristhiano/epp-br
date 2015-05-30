require 'helper'

class TestHello < Minitest::Test
  def test_hello
    client = EPP::BR::Client.new
    hello = client.hello
    assert_equal true, hello
  end
end
