class GithubService

  def get_repos(quantity = 0)
    repos = get_json('/user/repos')
    range = (quantity - 1)
    repos[0..range]
  end

  def get_followers
    get_json('/user/followers')
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token #{ENV["GITHUB_API_KEY"]}"
      faraday.adapter Faraday.default_adapter
    end
  end
end