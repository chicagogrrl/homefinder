module Homefinder::SearchRequest
  include HTTParty
  API_KEY = YAML.load_file( "#{Rails.root}/config/homefinder.yml" )['default']['api_key']
  base_uri "http://services.homefinder.com/listingServices/search?apikey=#{API_KEY}"

  def self.retrieve options
    options.each do |key,value|
      if value.is_a?(Hash)
        range = value.inject({}){|newhash,(k,v)| newhash[k] = v.blank? ? "*" : v; newhash}
        options[key] = "#{range["min"]} TO #{range["max"]}"
      end
    end
    data = get("", {query: options})
    JSON.parse(data)
  end

end