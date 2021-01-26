require 'rails_helper'

RSpec.describe Task, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
    it 'タイトルが無ければ無効な状態であること' do
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
    it 'ステータスが無ければ無効な状態であること' do
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
    
    # it 'タイトルがユニークでなければ無効な状態であること' do
    # end
    # it 'ステータスがなければ無効な状態であること' do
    # end
end
