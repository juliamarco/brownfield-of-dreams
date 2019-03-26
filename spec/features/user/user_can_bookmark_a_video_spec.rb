require 'rails_helper'

describe 'A registered user' do # rubocop:disable Metrics/BlockLength
  before :each do
    @tutorial = create(:tutorial, title: 'How to Tie Your Shoes', id: 2)
    @video = create(:video,
                    title: 'The Bunny Ears Technique',
                    tutorial: @tutorial,
                    position: 2)
    @user = create(:user)
  end
  it 'can add videos to their bookmarks' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user) # rubocop:disable Metrics/LineLength

    visit tutorial_path(@tutorial)

    expect { click_on 'Bookmark' }.to change { UserVideo.count }.by(1)

    expect(page).to have_content('Bookmark added to your dashboard')
  end

  it "can't add the same bookmark more than once" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user) # rubocop:disable Metrics/LineLength

    visit tutorial_path(@tutorial)

    click_on 'Bookmark'
    expect(page).to have_content('Bookmark added to your dashboard')
    click_on 'Bookmark'
    expect(page).to have_content('Already in your bookmarks')
  end

  it 'can see a list of bookmarked videos' do
    video_2 = create(:video,
                     title: 'The Best Video',
                     tutorial: @tutorial,
                     position: 3)
    tutorial_2 = create(:tutorial, title: 'How to survive Turing', id: 1)
    video_3 = create(:video,
                     title: 'Not easy',
                     tutorial: tutorial_2,
                     position: 1)

    user_video_1 = create(:user_video, user: @user, video: @video)
    user_video_2 = create(:user_video, user: @user, video: video_2)
    user_video_3 = create(:user_video, user: @user, video: video_3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user) # rubocop:disable Metrics/LineLength

    visit dashboard_path
    expect(page).to have_content('Bookmarked Segments')

    within '#bookmarks' do
      within(first('.bookmark')) do
        expect(page).to have_content(video_3.title)
        expect(page).to_not have_content(@video.title)
        expect(page).to_not have_content(video_2.title)
      end
      expect(page).to have_content(video_2.title)
      expect(page).to have_content(@video.title)
    end
  end
end
