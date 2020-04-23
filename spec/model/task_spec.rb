require 'rails_helper'

RSpec.describe Task, type: :model do

  describe "バリデーションのテスト" do
    # 正常系
    context "バリデーションが全て正しい時" do
      it "エラーにならない" do
        task = build(:task)
        # build が FB のメソッドでtasks.rbから:task を呼んでくる
        expect(task).to be_valid
      end
    end

    # 異常系
    describe "タイトルのバリデーションに関するテスト" do
      context "タイトルが空の時" do
        it "エラーになる" do
          task = build(:task, name: "")
          # create ではなく build。 validation は create の前に走る。タイトルを空にしたケース
          expect(task).not_to be_valid
          expect(task.errors.messages[:name]).to include("を入力してください")
        end
      end
    end

    context "タイトルが重複している時" do
      it "エラーになる" do
        task = create(:task)
        # Factory.Botから tasks.rb を呼びtaskを登録
        duplicated_task = build(:task, name: task.name)
        expect(duplicated_task.valid?).to eq(false)
        expect(duplicated_task.errors.messages[:name]).to include("はすでに存在します")
      end
    end
  end

  describe 'タスクの表示順テスト' do
    let(:task) { create(:task, created_at: Time.current) }
    let(:other_task) { create(:task, created_at: Time.current.prev_day(10)) }
    xit 'タスクが作成日時順で表示されること' do
      task
      other_task
      expect(Task.recent.map(&:id)).to eq [1, 2]
      # ransack実装のため一旦保留
    end
  end
end