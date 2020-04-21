FactoryBot.define do
  factory :task do
    sequence(:name) {|n| "テストタスク#{n}"}
    sequence(:description) {|n| "テスト説明#{n}"}
  end
end