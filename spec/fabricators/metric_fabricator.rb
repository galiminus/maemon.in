Fabricator(:metric) do
  name          { Faker::Skill.specialty      }
  value         { rand(10) + 1                }
end
