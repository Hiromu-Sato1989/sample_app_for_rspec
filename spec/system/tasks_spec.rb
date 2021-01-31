require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功する' do
          user = build(:user)
          expect(user).to be_valid
          # expect(user.errors).to be_empty
        end
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの新規作成が失敗する' do
          user = build(:user, email: "")
          expect(user).to be_invalid
        end
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する' do
          create(:user, email: "user@example.com")
          invalid_user = build(:user, email: "user@example.com")
          expect(invalid_user).to be_invalid
        end
      end
    end

    describe 'マイページ' do
      context 'ログインしていない状態' do
        it 'マイページへのアクセスが失敗する' do
          visit root_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before do
      @user = create(:user, email: "sample@example.com" )
      visit login_path
      fill_in 'Email', with: "sample@example.com"
      fill_in 'Password', with: "password"
      click_button 'Login'
    end
    describe 'ユーザー編集' do
      before do
        visit edit_user_path(1)
      end
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功する' do
          click_button 'Update'
          expect(@user.reload).to completed?
        end
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの編集が失敗する'
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの編集が失敗する'
      end
      context '他ユーザーの編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する'
      end
    end

    describe 'マイページ' do
      context 'タスクを作成' do
        it '新規作成したタスクが表示される'
      end
    end
  end
end

RSpec.describe 'UserSessions', type: :system do
  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'ログイン処理が成功する'
    end
    context 'フォームが未入力' do
      it 'ログイン処理が失敗する'
    end
  end

  describe 'ログイン後' do
    context 'ログアウトボタンをクリック' do
      it 'ログアウト処理が成功する'
    end
  end
end
