module EPP
  module BR
    class Contact < EPP::BR::Client

      # creator

      def create id, info = {}
        @command = EPP::Contact::Create.new(id, info)
        EPP::Contact::CreateResponse.new(super())
      end

      # info

      def info id
        @command = EPP::Contact::Info.new(id)
        EPP::Contact::InfoResponse.new(super())
      end

      # batch info

      def check ids, extension = nil
        @command = EPP::Contact::Check.new(ids, extension)
        EPP::Contact::CheckResponse.new(super())
      end

      # mutators

      def update id, info = {}
        @command = EPP::Contact::Update.new(id, info)
        EPP::Contact::UpdateResponse.new(super())
      end

      def transfer id
        @command = EPP::Contact::Transfer.new(id)
        EPP::Contact::TransferResponse.new(super())
      end

      # destructor

      def delete id
        @command = EPP::Contact::Delete.new(id)
        EPP::Contact::DeleteResponse.new(super())
      end
    end
  end
end
