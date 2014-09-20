Fabricator(:user) do
  name          { Faker::Name.name      }
  email         { Faker::Internet.email }
  provider      "google_oauth2"
end
