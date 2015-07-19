require 'helper'

class TestHomologation < Minitest::Test
  def setup
    @runner = EPP::BR::Homologation::Base.new
  end

  def test_connect
    @runner.run
    # server = @runner.connect
    #
    # assert server
  end
  #
  # def test_hello
  #   hello = @runner.hello
  #
  #   assert hello
  # end
  #
  # def test_contact_create
  #   contact_create = @runner.contact_create
  #
  #   assert contact_create.success?
  # end
  #
  # def test_contact_info
  #
  # end
end
