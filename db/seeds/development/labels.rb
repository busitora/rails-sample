require 'faker'

10.times do
  Label.create!(
      name: Faker::Game.unique.platform
      )
end