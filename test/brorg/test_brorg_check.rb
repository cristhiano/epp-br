require 'helper'


class TestBrorgCheck < Minitest::Test
  def setup()
    @client = EPP::BR::Client.new 'test'
    @brorg = @client.organization
  end

  def test_against_schema
    @response = @brorg.check Faker::CPF.cpf

    @xml = @brorg.command.to_xml
  end
end
