require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:position) }
    it { should validate_numericality_of(:position).allow_nil }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:video_id) }
    it { should validate_presence_of(:description) }
  end

  describe 'relationships' do
    it { should belong_to :tutorial }
    it { should have_many :user_videos }
    it { should have_many :users }
  end
end
