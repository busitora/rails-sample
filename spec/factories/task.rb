FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "テストタスク#{n}" }
    sequence(:description) { |n| "テスト説明#{n}" }
    limit { Time.current.next_day(10) }
  end

  trait :task_10days_ago do
    created_at { Time.current.prev_day(10) }
    limit { Time.current.prev_day(10) }
  end

end