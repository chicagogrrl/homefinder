module Homefinder::SearchRequest
  include HTTParty
  API_KEY = ENV['HOMEFINDER_API_KEY']
  base_uri "http://services.homefinder.com/listingServices/search?apikey=#{API_KEY}"

  def self.retrieve params
    options = params.clone
    options.each do |key,value|
      if value.is_a?(Hash)
        range = value.inject({}){|newhash,(k,v)| newhash[k] = v.blank? ? "*" : v; newhash}
        options[key] = "#{range["min"]} TO #{range["max"]}"
      end
    end
    data = get("", {query: options})
    JSON.parse(data)
  end

  def self.retrieve_single id
    data = get("", {query: {id: id}})
    JSON.parse(data)
  end

end