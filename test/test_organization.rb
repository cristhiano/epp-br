require 'helper'
require 'fixtures/organization'

class TestOrganization < MiniTest::Test
  def test_organization_lifecycle
    @fixture = OrganizationFixture.info

    # Check
    @check = @client.organization.check @fixture.clone[:brorg][:organization]
    assert_instance_of EPP::Contact::CheckResponse, @check, 'Response is not an instance of EPP::Contact::CreateResponse'
    assert_equal true, @check.success?, 'Organization check failed'

    # Check multiple
    @check = @client.organization.check OrganizationFixture.multiple_documents
    assert_instance_of EPP::Contact::CheckResponse, @check, 'Response is not an instance of EPP::Contact::CreateResponse'
    assert_equal true, @check.success?, 'Organization check failed'

    # Create
    # @create = @client.organization.create 'NONEXISTE', @fixture.clone
    # @id = @create.id
    # assert_instance_of EPP::Contact::CreateResponse, @create, 'Response is not an instance of EPP::Contact::CreateResponse'
    # assert_equal true, @create.success?, 'Organization create failed'

    # Info
    # @info = @client.contact.info @id
    # assert_instance_of EPP::Contact::InfoResponse, @info, 'Response is not an instance of EPP::Contact::InfoResponse'
    # assert_equal @fixture[:email], @info.email
    #
    # # Update
    # @update_fixture = {chg: {email: Faker::Internet.email}}
    # @update = @client.contact.update @id, @update_fixture.clone
    # assert_instance_of EPP::Contact::UpdateResponse, @update, 'Response is not an instance of EPP::Contact::UpdateResponse'
    # assert_equal true, @update.success?, 'Organization update failed'
  end
end
