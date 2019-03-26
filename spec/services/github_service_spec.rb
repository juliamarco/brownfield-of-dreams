require 'rails_helper'

describe GithubService do # rubocop:disable Metrics/BlockLength
  before :each do
    @user = create(:user)
  end

  it 'exists' do
    service = GithubService.new
    expect(service).to be_a(GithubService)
  end

  describe 'instance methods' do # rubocop:disable Metrics/BlockLength
    it 'get repositories' do
      VCR.use_cassette('github service repos') do
        service = GithubService.new

        result = service.get_repos(@user)
        expect(result).to be_a(Array)
        expect(result[0]).to be_a(Hash)
        expect(result[0]).to have_key(:name)
      end
    end

    it 'get followers' do
      VCR.use_cassette('github service followers') do
        service = GithubService.new

        result = service.get_followers(@user)
        expect(result).to be_a(Array)
        expect(result[0]).to be_a(Hash)
        expect(result[0]).to have_key(:login)
      end
    end

    it 'get following' do
      VCR.use_cassette('github service following') do
        service = GithubService.new

        result = service.get_following(@user)
        expect(result).to be_a(Array)
        expect(result[0]).to be_a(Hash)
        expect(result[0]).to have_key(:login)
      end
    end
  end
end
