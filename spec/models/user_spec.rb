require 'rails_helper'

RSpec.describe User, type: :model do # rubocop:disable Metrics/BlockLength
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:password) }
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com',
                          password: 'password',
                          first_name: 'Jim',
                          role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com',
                          password: 'admin',
                          first_name: 'Bob',
                          role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'class methods' do
    it '.bookmarks' do
      tutorial_2 = create(:tutorial, title: 'How to survive Turing', id: 1)
      tutorial_1 = create(:tutorial, title: 'How to bark', id: 2)

      video_1 = create(:video,
                       title: 'The Bunny Ears Technique',
                       tutorial: tutorial_1,
                       position: 3)

      video_2 = create(:video,
                       title: 'The Best Video',
                       tutorial: tutorial_1,
                       position: 2)

      video_3 = create(:video,
                       title: 'Not easy',
                       tutorial: tutorial_2,
                       position: 1)

      user = create(:user)
      user_video_1 = create(:user_video, user: user, video: video_1)
      user_video_2 = create(:user_video, user: user, video: video_2)
      user_video_3 = create(:user_video, user: user, video: video_3)

      expect(User.bookmarks(user)).to eq([video_3, video_2, video_1])
    end
  end
end
