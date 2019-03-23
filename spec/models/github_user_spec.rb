require 'rails_helper'

describe GithubUser do
  before :each do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    VCR.use_cassette("github service followers") do
      @github_data = GithubService.new.get_followers(user)[0]
      @follower = GithubUser.new(@github_data)
    end
  end

  it 'exists' do
    expect(@follower).to be_a(GithubUser)
  end

  it 'has a handle' do
    expect(@follower.handle).to eq(@github_data[:login])
  end
end
