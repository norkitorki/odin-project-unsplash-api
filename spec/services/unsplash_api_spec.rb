require 'rails_helper'
require_relative '../support/faraday_double'

RSpec.describe UnsplashApi do
  it "should define BASE_URL class constant" do
    expect(UnsplashApi::BASE_URL).to eq("https://api.unsplash.com")
  end

  describe '#collection_photos' do
    include_context 'faraday double'

    let(:collection_id) { "v_gegYsM354323" }

    it "calls Faraday.get and returns response" do
      api = UnsplashApi.new
      response = api.collection_photos(collection_id)
      url = "https://api.unsplash.com/collections/#{collection_id}/photos"
      headers = { Authorization: "Client-ID super_secret_key", "Content-Type": "application/json" }

      expect(Faraday).to have_received(:get).with(url, nil, headers)
      expect(response).to eq(faraday_response)
    end

    context "when unsplash_key env variable is undefined" do
      before(:all) { ENV["unsplash_key"] = nil }

      it "returns message" do
        api = UnsplashApi.new
        response = api.collection_photos(collection_id)

        expect(response).to eq("Please define access key in ENV['unsplash_key']")
      end

      it "omits call to Faraday.get" do
        api = UnsplashApi.new
        api.collection_photos(collection_id)

        expect(Faraday).to_not have_received(:get)
      end
    end
  end
end
