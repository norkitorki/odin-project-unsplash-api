class UnsplashApi
  BASE_URL = "https://api.unsplash.com"

  def collection_photos(collection_id)
    return "Please define access key in ENV['unsplash_key']" unless ENV["unsplash_key"]

    request("#{BASE_URL}/collections/#{collection_id}/photos")
  end

  private

  def request(url, params = nil)
    Faraday.get(url, params, { Authorization: "Client-ID #{ENV["unsplash_key"]}", "Content-Type": "application/json" })
  end

  def key_defined?
    !ENV["unsplash_key"].nil?
  end
end
