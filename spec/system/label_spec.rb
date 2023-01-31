require 'rails_helper'
RSpec.describe 'ラベル追加機能', type: :system do
  before do
    label = FactoryBot.create(:label)
    user = FactoryBot.create(:admin_user)
    visit new_session_path
    fill_in 'session[email]', with: 'admin@gmail.com'    
    fill_in 'session[password]', with: '000000'    
    click_on 'Log in'
    @current_user = User.find_by(email: "admin@gmail.com")
    visit new_task_path
    sleep(2)
    fill_in 'task[title]', with: 'うんち'    
    fill_in 'task[content]', with: '中身なし'
    fill_in 'task[limit]', with: "002022-12-31"
    select "未着手", from: 'ステータス'
    check "ライフル"
    click_on 'タスク作成'
  end
  describe '新規作成機能' do
    context 'ラベルを含むタスクを新規作成した場合' do
      it '設定したラベルが詳細画面に存在する' do
        click_on '詳細', match: :first
        expect(page).to have_content 'ライフル'
      end
    end
  end
  describe 'ラベル検索機能' do
    context '一覧画面でラベルを選択すると' do
      it 'そのラベルで絞り込みができる' do
        visit tasks_path
        select 'ライフル', from:'search_label_id'
        click_button '検索'
        expect(page).to have_content 'ライフル'
      end
    end
  end
end