require 'rails_helper'

describe YouTube::Video, type: :model do
  it 'exists' do
    data = { items: [snippet: { thumbnails: { high: { url: 'brownfield' } } }] }
    video = YouTube::Video.new(data)

    expect(video).to be_a(YouTube::Video)
    expect(video.thumbnail).to eq('brownfield')
  end

  describe 'instance methods' do
    it '#by_id', :vcr do
      expect(YouTube::Video.by_id('ktYlzVYQbwY')).to be_a(YouTube::Video)
    end
  end
end
