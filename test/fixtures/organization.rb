class OrganizationFixture
  def self.id
    Faker::Number.number(6).to_s
  end

  def self.generate
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
        :organization   => "005.506.560/0001-36",
        :contact        => "fan",
        :responsible    => "John Doe"
      }
    }

    organization
  end
end
