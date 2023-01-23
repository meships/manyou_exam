require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do

  describe 'ユーザー登録機能' do
    context 'ユーザーを新規登録した場合' do
      it 'ログインした状態' do
        visit new_user_path
        fiil_in 'user[name]', with: ''
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with ''
        click_button ""
        expect(page).to have_content ''
      end
    end
    