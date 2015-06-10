module EPP
  module BR
    class Contact < EPP::BR::Client
      # batch

      def check ids
        @command = EPP::Contact::Check.new(ids)
        EPP::Contact::CheckResponse.new(super())
      end

      # actions

      def info id
        @command = EPP::Contact::Info.new(id)
        EPP::Contact::InfoResponse.new(super())
      end

      def transfer id
        @command = EPP::Contact::Transfer.new(id)
        EPP::Contact::TransferResponse.new(super())
      end

      def delete id
        @command = EPP::Contact::Delete.new(id)
        EPP::Contact::DeleteResponse.new(super())
      end

      # creator / mutator

      def create id, info = {}
        @command = EPP::Contact::Create.new(id, info)
        EPP::Contact::CreateResponse.new(super())
      end

      def update id, info = {}
        @command = EPP::Contact::Update.new(id, info)
        EPP::Contact::UpdateResponse.new(super())
      end
    end
  end
end
