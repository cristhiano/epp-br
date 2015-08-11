class DomainMock
  def self.name
    "#{Faker::Internet.domain_word}.com.br"
  end

  def self.params custom = {}
    {
      nameservers: [
        {
          name: "ns.#{Faker::Internet.domain_name}",
          ipv4: Faker::Internet.ip_v4_address
        },
        {
          name: "ns.#{Faker::Internet.domain_name}",
          ipv4: Faker::Internet.ip_v4_address,
          ipv6: Faker::Internet.ip_v6_address
        }
      ],
      brorg: Faker::CNPJ.pretty,
      registrant: 'registrant',
      auth_info: {
        pw: 'pw'
      }
    }.merge! custom
  end

  def self.add_rem_ns add, rem
    {
      rem: {
        ns: rem
      },
      add: {
        ns: add
      }
    }
  end
end