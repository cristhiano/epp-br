class DomainFixture
  def self.id
    Faker::Number.number(6).to_s
  end

  def self.info
    organization = {
      :email       => Faker::Internet.email,
      :voice       => "55.1198765432",
      :postal_info => {
        :org          => Faker::Name.name,
        :name         => Faker::Name.name,
        :addr         => {
          :street       => "Test Suite\n1 Test Avenue",
          :city         => "Sao Paulo",
          :sp           => "SP",
          :pc           => "01201-060",
          :cc           => "BR"
        }
      },
      :auth_info   => {:pw => Faker::Internet.password},
      :disclose    => {"0" => %w(voice email)},
      :brorg       => {
        :organization   => "61.315.534/0001-00",
        :contact        => "fan",
        :responsible    => "John Doe"
      }
    }

    organization
  end

  def self.multiple_documents
    ["38.744.244/0001-51", "87.684.781/0001-69", "73.262.412/0001-73"]
  end
end
