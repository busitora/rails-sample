require 'rails_helper'

RSpec.describe "Task", type: :system do
  describe 'タスクのCRUDの動作確認' do
    let(:task) { create(:task) }
    let(:other_task) { create(:task) }

    context 'タスク一覧のとき' do
      it 'タスク一覧が表示されること' do
        task
        other_task
        visit root_path
        expect(page).to have_content task.name
        expect(page).to have_content other_task.name
        expect(current_path).to eq(root_path)
        # Task.findとか DBに格納されるかまではテストしない
      end
    end

    context 'タスク作成のとき' do
      it 'バリデーションが正しいのでタスクが作られること' do
        visit new_task_path
        fill_in 'task[name]', with: '最初のタスク'
        fill_in 'task[description]', with: '最初の説明'
        click_button '登録する'
        expect(page).to have_content 'タスク「最初のタスク」を登録しました。'
        expect(current_path).to eq(tasks_path)
      end

      it '既にあるタスク名なのでタスクが作られないこと' do
        visit new_task_path
        fill_in 'task[name]', with: task.name
        # letで作成済みのタスク名なので presence: trueで落ちる
        fill_in 'task[description]', with: '最初の説明'
        click_button '登録する'
        expect(page).to have_content 'タスクの登録に失敗しました。'
        expect(page).to have_content 'タスク名はすでに存在します'
        expect(current_path).to eq(tasks_path)
        # renderなので newだと検知できない
      end
    end

    context 'タスク編集のとき' do
      it 'タスクが編集できること' do
        visit edit_task_path(task)
        fill_in 'task[name]', with: 'タスクの変更'
        fill_in 'task[description]', with: 'タスクの変更ですよ'
        click_button '更新する'
        expect(page).to have_content 'タスク「タスクの変更」を更新しました。'
        expect(current_path).to eq(task_path(task))
      end
    end

    context 'タスク削除の時' do
      it 'タスクが削除されること' do
        visit edit_task_path(task)
        click_link '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'タスクを削除しました'
        expect(current_path).to eq(tasks_path)
      end
    end
  end
  # TODO: ユーザーに紐付けるとなると大幅にテストを変更する必要がある。。
end