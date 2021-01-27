require 'rails_helper'

RSpec.describe Task, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'validates' do
    it '有効であること' do
      # user = FactoryBot.create(:user)
      task = FactoryBot.build(:task)
      expect(task).to be_valid
    end
    it 'タイトルが無ければ無効であること' do
      # user = FactoryBot.create(:user)

      task = FactoryBot.build(:task, title: nil)
      task.valid?
      expect(task.errors[:title]).to include("can't be blank")
    end
    it 'ステータスが無ければ無効であること' do
      # user = FactoryBot.create(:user)

      task = FactoryBot.build(:task, status: nil)
      task.valid?
      expect(task.errors[:status]).to include("can't be blank")
    end
    it 'タイトルが一意でなければ無効な状態であること' do
      # user = FactoryBot.create(:user)

      task = FactoryBot.create(:task)
      task_with_another_title = FactoryBot.build(:task, title: task.title)
      task_with_another_title.valid?
      expect(task_with_another_title.errors[:title]).to include("has already been taken")
    end
    it 'タイトルが一意であれば有効であること' do
      # user = FactoryBot.create(:user)

      task = FactoryBot.create(:task)
      task_with_another_title = FactoryBot.create(:task, title: 'another_title')
      expect(task_with_another_title).to be_valid
    end
  end
end
