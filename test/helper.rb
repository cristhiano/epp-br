require 'minitest/autorun'

require 'webmock/minitest'

require 'faker'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'epp-br'

require 'minitest/unit'

class MiniTest::Test
  def setup()
    @client = EPP::BR::Client.new 'test'
  end

  def teardown()
    # if @resp && @resp.success? == false
    #   puts [@resp.message, @resp.error_reason].join(': ')
    # end
  end

  # def contact_req_resp(@req, @resp)
  #   # compare = lambda do |key, value|
  #   # @req.each do |key, value|
  #     unless value.instance_of? Array
  #       assert_equal value, @resp.send key
  #     else
  #
  #     end
  #   end
  #
  #
  # end
end
