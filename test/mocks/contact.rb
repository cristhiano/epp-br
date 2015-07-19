class ContactMock
  def self.id
    Faker::Number.number(6).to_s
  end

  def self.params custom = {}
    {
      email:       Faker::Internet.email,
      voice:       "55.1198765432",
      auth_info:   {pw: Faker::Internet.password},
      disclose:    {"0" => %w(voice email)},
      postal_info: {
        org:          Faker::Name.name,
        name:         Faker::Name.name,
        addr:         {
          street:       "Test Suite\n1 Test Avenue",
          # street:       Faker::Address.street_name,
          city:         "Sao Paulo",
          sp:           "SP",
          pc:           "01201-060",
          cc:           "BR"
        }
      }
    }.merge! custom
  end

  def self.change
    {
      chg: {
        postal_info: {
          addr: {
            street: "Rua Bar"
          }
        },
        voice: '55.1198765433',
        email: Faker::Internet.email,
      }
    }
  end
end
