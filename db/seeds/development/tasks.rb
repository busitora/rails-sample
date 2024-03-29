require 'faker'

30.times do
  Task.create!(
      name: Faker::JapaneseMedia::OnePiece.unique.character,
      description: Faker::JapaneseMedia::OnePiece.quote,
      limit: Faker::Time.between(from: DateTime.now + 10, to: DateTime.now),
      status: rand(0..2),
      priority: rand(0..3),
      user_id: 1,
  # TODO: ラベル
  )
end

10.times do
  Task.create!(
      name: Faker::JapaneseMedia::DragonBall.unique.character,
      description: Faker::JapaneseMedia::OnePiece.quote,
      limit: Faker::Time.between(from: DateTime.now + 10, to: DateTime.now),
      status: rand(0..2),
      priority: rand(0..3),
      user_id: 3,
      )
end
