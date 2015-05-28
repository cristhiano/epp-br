require 'helper'
require 'fixtures/contact'

class TestContact < MiniTest::Test
  def test_contact_lifecycle
    @fixture = ContactFixture.info

    # Create
    @create = @client.contact.create 'NONEXISTE', @fixture.clone
    @id = @create.id
    assert_instance_of EPP::Contact::CreateResponse, @create, 'Response is not an instance of EPP::Contact::CreateResponse'
    assert_equal true, @create.success?, 'Contact create failed'

    # Info
    @info = @client.contact.info @id
    assert_instance_of EPP::Contact::InfoResponse, @info, 'Response is not an instance of EPP::Contact::InfoResponse'
    assert_equal @fixture[:email], @info.email

    # Update
    @update_fixture = {chg: {email: Faker::Internet.email}}
    @update = @client.contact.update @id, @update_fixture.clone
    assert_instance_of EPP::Contact::UpdateResponse, @update, 'Response is not an instance of EPP::Contact::UpdateResponse'
    assert_equal true, @update.success?, 'Contact update failed'
  end
end
