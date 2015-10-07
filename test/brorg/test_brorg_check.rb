require 'helper'
require 'cpf_faker'

class TestBrorgCheck < Minitest::Test
  def setup()
    @client = EPP::BR::Client.new 'test'
    @brorg = @client.brorg
  end

  def test_against_schema
    @brorg.check Faker::CPF.cpf

    @brorg_check = @brorg.command

    @check   = EPP::Commands::Check.new(@brorg_check)
    @command = EPP::Requests::Command.new('ABC-123', @check)
    @request = EPP::Request.new(@command)
    @xml     = @request.to_xml

    @schema = schema('brorg-06')
    assert @xml.validate_schema(@schema)
  end

  
end
