require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        date = Date.new(2013,12,11)
        visit new_task_path
        fill_in 'task[title]', with: 'task'
        fill_in 'task[content]', with: 'task'
        fill_in 'task[limit]', with: date
        #select '未着手', form: 'task[status]'
        #find("status").find("option[value='完了']").select_option
        select "未着手", from: 'ステータス'

        #fill_in 'task[priority]', with: '高'
        
        click_on 'タスク作成'
        expect(page).to have_content 'task'
        expect(page).to have_content 'task'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path
        expect(page).to have_content 'うんち'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path
        task_list = page.all('.task_row')
        expect(task_list.first).to have_content 'うんち'
      end
    end

    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限が早いタスクが一番上に表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path
        tasks_path(sort_limit: "true") 
        task_list = all('.task_row')
        click_link  "終了期限"
        expect(task_list.first).to have_content "うんち"
      end
    end

  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title: 'task', content: 'task')
        visit task_path(task)
        expect(page).to have_content 'task'
       end
     end
  end

end

describe '検索機能' do
  #before do
    # 必要に応じて、テストデータの内容を変更して構わない
    #FactoryBot.create(:task, title: "task")
    #FactoryBot.create(:second_task, title: "sample")
  #end

  context 'タイトルであいまい検索をした場合' do
    it "検索キーワードを含むタスクで絞り込まれる" do
      task1 = FactoryBot.create(:task, title: 'task')
      task2 = FactoryBot.create(:task, title: 'うまいもん')
      task3 = FactoryBot.create(:task, title: 'たべたい')
      visit tasks_path
      fill_in 'search_title', with: 'ta' 
      #fill_in 'search[title]' ブラウザで検証ツールを使って検索窓のIDもしくはnameを確認する
      click_button "検索"
      expect(page).to have_content task1.title
      expect(page).not_to have_content task2.title
    end
  end

  context 'ステータス検索をした場合' do
    it "ステータスに完全一致するタスクが絞り込まれる" do
      task1 = FactoryBot.create(:task, status: 1 )
      task2 = FactoryBot.create(:task, status: 2 )
      task3 = FactoryBot.create(:task, status: 3 )
      visit tasks_path
      select '完了', from: 'search_status'
      click_button "検索"
      expect(page).to have_content task3.status
    end
  end

  context 'タイトルのあいまい検索とステータス検索をした場合' do
    it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
      task1 = FactoryBot.create(:task, title: 'task')
      task2 = FactoryBot.create(:task, title: 'うまいもん')
      task3 = FactoryBot.create(:task, title: 'たべたい')
      task4 = FactoryBot.create(:task, status: 1 )
      task5 = FactoryBot.create(:task, status: 2 )
      task6 = FactoryBot.create(:task, status: 3 )
      visit tasks_path
      fill_in 'search_title', with: 'ta'
      select '完了', from: 'search_status'
      click_button "検索"
      expect(page).to have_content task1.title
      expect(page).to have_content task6.status
      expect(page).not_to have_content task2.title
    end
  end
  
end