require 'minitest/autorun'

require 'webmock/minitest'
include WebMock::API

require 'faker'
require 'epp-br'
require 'minitest/unit'

class MiniTest::Test
  def setup()
    @client = EPP::BR::Client.new
  end

  def teardown()
    if @resp && @resp.success? == false
      puts [@resp.message, @resp.error_reason].join(': ')
    end
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
