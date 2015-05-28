require 'helper'

class TestHello < Minitest::Test
  def test_hello
    client = EPP::RegistroBR::Client.new
    hello = client.hello
    assert_equal true, hello
  end
end
