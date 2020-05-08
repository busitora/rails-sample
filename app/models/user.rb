class User < ApplicationRecord
  before_destroy :least_one_admin
  has_secure_password
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, uniqueness: {case_sensitive: true}
  validates :email, presence: true, uniqueness: true
  enum role: %i[normal admin]

  private

  def least_one_admin
    throw(:abort) if User.admin.count == 1
    # TODO: 下記のようなメッセージ出したいが出せてない、毎回countするのもいかがなものか。
    # flash.now[:danger] = "管理者が最後の一人の場合は削除できません"
  end
end
