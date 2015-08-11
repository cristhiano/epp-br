require 'helper'

class TestBrorgCheck < Minitest::Test
  def setup
    @brorg = @client.organization.check Faker::CPF.cpf
  end

  # def test_against_schema
  #   assert @brorg.validate_schema(schema)
  # end
end
