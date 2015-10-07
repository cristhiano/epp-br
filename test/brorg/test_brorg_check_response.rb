require 'helper'
require 'cpf_faker'

class TestBrorgCheckResponse < Minitest::Test
  def setup()
    @response = EPP::Response.new(load_xml('brorg/check-single'))
    @check_response = EPP::BR::Org::CheckResponse.new(@response)
  end

  def test_success
    assert @check_response.success?
  end

  def test_message
    assert_equal 'Command completed successfully', @check_response.message
  end

  def test_available
    assert_equal false, @check_response.available?
  end
end
