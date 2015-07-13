require 'helper'
require 'helpers/lifecycle'
require 'fixtures/contact'

class TestContact < Minitest::Test
  def test_contact_lifecycle
    self.entity_name = 'contact'
    self.fixture = ContactFixture.info

    lifecycle

    # @fixture = ContactFixture.info
    #
    # # Create
    # @create = @client.contact.create 'NONEXISTE', @fixture.clone
    # @id = @create.id
    # assert_instance_of EPP::Contact::CreateResponse, @create, 'Response is not an instance of EPP::Contact::CreateResponse'
    # assert_equal true, @create.success?, 'Contact create failed'
    #
    # # Info
    # @info = @client.contact.info @id
    # assert_instance_of EPP::Contact::InfoResponse, @info, 'Response is not an instance of EPP::Contact::InfoResponse'
    # assert_equal @fixture[:email], @info.email
    #
    # # Update
    # @update_fixture = {chg: {email: Faker::Internet.email}}
    # @info = @update_fixture.clone
    # @info[:email] = 'email@example.com'
    # @update = @client.contact.update @id, @info
    # assert_instance_of EPP::Contact::UpdateResponse, @update, 'Response is not an instance of EPP::Contact::UpdateResponse'
    # assert_equal true, @update.success?, 'Contact update failed'
    #
    # # Poll
    # @poll = @client.poll
    # p @poll.msgQ['count']
    # p @poll.msgQ['id']
    # # p @poll.message
    # p @poll.data.to_s
    #
    # @ack = @client.ack(@poll.msgQ['id'])

    # sleep 60
    # @contact = @client.contact.info @id
    # assert_equal @info[:email], @contact.email
  end
end
