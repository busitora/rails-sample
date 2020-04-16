class Task < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  # ユニーク制約は一応貼っておく
  # TODO DB上でユニークが設定出来てるか不明瞭
end
