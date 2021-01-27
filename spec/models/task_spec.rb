require 'rails_helper'

RSpec.describe Task, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'validates' do
    it '有効であること' do
      user = FactoryBot.create(:user)
      task = user.tasks.create(
        title: "example",
        content: "hogehoge",
        status: "todo",
        deadline: Time.zone.now
      )
      expect(task).to be_valid
    end
    it 'タイトルが無ければ無効であること' do
      user = FactoryBot.create(:user)

      task = user.tasks.new(
        title: nil,
        content: "hogehoge",
        status: "todo",
        deadline: Time.zone.now
      )
      task.valid?
      expect(task.errors[:title]).to include("can't be blank")
    end
    it 'ステータスが無ければ無効であること' do
      user = FactoryBot.create(:user)

      task = user.tasks.new(
        title: "example",
        content: "hogehoge",
        status: nil,
        deadline: Time.zone.now
      )
      task.valid?
      expect(task.errors[:status]).to include("can't be blank")
    end
    it 'タイトルが一意でなければ無効な状態であること' do
      user = FactoryBot.create(:user)

      task = user.tasks.create(
        title: "example",
        content: "hogehoge",
        status: "todo",
        deadline: Time.zone.now
      )
      task_with_another_title = user.tasks.create(
        title: "example",
        content: "hogehoge",
        status: "todo",
        deadline: Time.zone.now
      )
      task_with_another_title.valid?
      expect(task_with_another_title.errors[:title]).to include("has already been taken")
    end
    it 'タイトルが一意であれば有効であること' do
      user = FactoryBot.create(:user)

      task1 = user.tasks.create(
        title: "example",
        content: "hogehoge",
        status: "todo",
        deadline: Time.zone.now
      )
      task2 = user.tasks.create(
        title: "example2",
        content: "hogehoge",
        status: "todo",
        deadline: Time.zone.now
      )
      expect(task2).to be_valid
    end
  end
end
