module Homefinder::SearchRequest
  include HTTParty
  API_KEY = YAML.load_file( "#{Rails.root}/config/homefinder.yml" )['default']['api_key']
  base_uri "http://services.homefinder.com/listingServices/search?apikey=#{API_KEY}"

  def self.simple
    data = get("&area=60016&resultsize=1")
    JSON.parse(data)
  end

end