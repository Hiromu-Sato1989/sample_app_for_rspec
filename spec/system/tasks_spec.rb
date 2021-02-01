require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  let(:user) { create(:user) }
  let(:task) { create(:task) }
  describe 'ログイン後' do
    before { login(user) }
    describe 'タスクの新規作成' do
      context 'フォームの入力値が正常' do
        it 'タスクの新規作成が成功する' do
          click_link 'New Task'
          fill_in 'Title', with: "title"
          fill_in 'Content', with: "content"
          select 'doing', from: 'Status'
          fill_in 'Deadline', with: 1.week.from_now
          click_button 'Create Task'
          expect(current_path).to eq '/tasks/1'
          expect(page).to have_content "Task was successfully created."
        end
      end
      context 'タイトルが未入力' do
        it 'タスクの新規作成が失敗する' do
          click_link 'New Task'
          fill_in 'Title', with: ""
          fill_in 'Content', with: "content"
          select 'doing', from: 'Status'
          fill_in 'Deadline', with: 1.week.from_now
          click_button 'Create Task'
          expect(current_path).to eq tasks_path
          expect(page).to have_content "Title can't be blank"
        end
      end
      context '登録済みのタイトルを入力' do
        it 'タスクの新規作成が失敗する' do
          create(:task, title: 'title')
          click_link 'New Task'
          fill_in 'Title', with: "title"
          fill_in 'Content', with: "content"
          select 'doing', from: 'Status'
          fill_in 'Deadline', with: 1.week.from_now
          click_button 'Create Task'
          expect(current_path).to eq tasks_path
          expect(page).to have_content "Title has already been taken"
        end
      end
    end
    describe 'タスクの編集' do
      let!(:task) { create(:task, user: user) }
      context 'フォームの入力値が正常' do
        it 'タスクの編集が成功する' do
          visit edit_task_path(task)
          fill_in 'Title', with: 'new_title'
          select 'doin', from: 'Status'
          click_button 'Update Task'
          expect(current_path).to eq '/tasks/1'
          expect(page).to have_content "Task was successfully updated."
        end
      end
      context 'タイトルが未入力' do
        it 'タスクの編集が失敗する' do 
          visit edit_task_path(task)
          fill_in 'Title', with: ''
          select 'doin', from: 'Status'
          click_button 'Update Task'
          expect(current_path).to eq '/tasks/1'
          expect(page).to have_content "Title can't be blank"
        end
      end
    end
  end
end
