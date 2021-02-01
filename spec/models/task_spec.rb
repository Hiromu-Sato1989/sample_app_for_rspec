require 'rails_helper'

RSpec.describe Task, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'validates' do
    it '有効であること' do
      # user = FactoryBot.create(:user)
      task = build(:task)
      expect(task).to be_valid
      expect(task.errors).to be_empty
    end
    it 'タイトルが無ければ無効であること' do
      # user = FactoryBot.create(:user)

      task_without_title = build(:task, title: nil)
      expect(task_without_title).to be_invalid
      expect(task_without_title.errors[:title]).to include("can't be blank")
    end
    it 'ステータスが無ければ無効であること' do
      # user = FactoryBot.create(:user)

      task_without_status = build(:task, status: nil)
      expect(task_without_status).to be_invalid
      expect(task_without_status.errors[:status]).to include("can't be blank")
    end
    it 'タイトルが一意でなければ無効な状態であること' do
      # user = FactoryBot.create(:user)

      task = create(:task)
      task_with_duplicated_title = build(:task, title: task.title)
      expect(task_with_duplicated_title).to be_invalid
      expect(task_with_duplicated_title.errors[:title]).to include("has already been taken")
    end
    it 'タイトルが一意であれば有効であること' do
      # user = FactoryBot.create(:user)

      task = create(:task)
      task_with_another_title = build(:task, title: 'another_title')
      expect(task_with_another_title).to be_valid
      expect(task_with_another_title.errors).to be_empty
    end
  end
end
