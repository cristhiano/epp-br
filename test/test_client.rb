require 'helper'

class TestClient < Minitest::Test
  def test_brorg
    brorg = @client.brorg

    assert_instance_of EPP::BR::Org, brorg
  end

  def test_contact
    contact = @client.contact

    assert_instance_of EPP::BR::Contact, contact
  end

  def test_domain
    brdomain = @client.brdomain

    assert_instance_of EPP::BR::Domain, brdomain
  end
end
