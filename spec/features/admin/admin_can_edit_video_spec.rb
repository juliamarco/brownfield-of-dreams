require 'rails_helper'

describe 'An Admin can edit a video' do
  before :each do
    @video = create(:video)
    @admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin) # rubocop:disable Metrics/LineLength
  end

  it 'can edit a video' do
    visit edit_admin_video_path(@video)

    fill_in 'video[position]', with: nil
    click_on 'Submit'

    expect(current_path).to eq(tutorial_path(@video.tutorial))
  end
end
