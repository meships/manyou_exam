require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  #let!(:task) { FactoryBot.create(:task, title: 'task') }

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
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list.first).to have_content 'task'
      end
    end

    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限が早いタスクが一番上に表示される' do
        visit tasks_path
        tasks_path(sort_expired: "true") 
        task_list = all('.task_row')
        expect(task_list.first).to have_content '2022/12/14'
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