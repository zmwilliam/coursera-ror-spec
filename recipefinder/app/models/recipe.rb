class Recipe
  include HTTParty
  #debug_output $stdout

  key_value = ENV['FOOD2FORK_KEY'] || "de7f23deb1add9e6f0faa63647f10d6d"
  hostport = ENV['FOOD2FORK_SERVER_AND_PORT'] || 'www.food2fork.com'

  base_uri "http://#{hostport}/api/search"
  default_params key: key_value#, q: "search"
  format :json

  def self.for term
    response = get("", query: {q: term})
    response["recipes"]
  end
end
