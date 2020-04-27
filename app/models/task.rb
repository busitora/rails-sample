class Task < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: {case_sensitive: true}
  # ユニーク制約は一応貼っておく
  # TODO: DB上でユニークが設定出来てるか不明瞭
  scope :recent, -> { order(created_at: :desc) }
  enum status: %i[waiting working done]
  enum priority: %i[not_yet small medium large]
end
