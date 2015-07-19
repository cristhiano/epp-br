require 'helper'

class Minitest::Test

  attr_accessor :entity_name,
                :entity_class_name,
                :mock

  def lifecycle
    @entity_class_name = @entity_name.capitalize

    commands = [:create]

    commands.each do |command_name|
      self.send(command_name)
      msg = self.poll
    end

  end

  def assert_epp_response response
    # Extract the command name from the caller method name
    command_class_name = caller[0][/`.*'/][1..-2].capitalize
    response_class_name = "EPP::#{@entity_class_name}::#{command_class_name}Response"
    response_class = response_class_name.split('::').inject(Object) {|o,c| o.const_get c}

    assert_instance_of response_class, response,
      "Response is not an instance of #{response_class_name}"

    assert response.success?, 'Contact create failed'
  end

  # Commands

  def create
    create = @client.send(@entity_name).create('NONEXISTE', @mock.clone)
    @id = create.id

    assert_epp_response create
  end

  def info
    info = @client.contact.info @id
    assert_epp_response info
    # assert_equal @mock[:email], info.email
  end

  def poll
    poll = @client.poll

    if poll.msgQ && poll.msgQ['count'].to_i > 0
      p poll.message

      return poll.msgQ['id']
    end
  end

  def ack

  end

  def check

  end

  def update
    @update_fixture = {}
  end

  def transfer

  end

  def renew

  end

  def delete

  end
end
