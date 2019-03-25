class GithubUser
  attr_reader :attributes,
              :handle

  def initialize(attributes)
    @attributes = attributes
    @handle = attributes[:login]
  end
end
