require 'rails_helper'

original_unsplash_key = ENV["unsplash_key"]

RSpec.describe "Collections", type: :request do
  let(:faraday_response) { double(status: 200, body: "[{\"urls\":{\"small\":\"\"},\"links\":{\"html\":\"\",\"download\":\"\"},\"user\":{\"name\":\"\",\"links\":{\"html\":\"\"},\"profile_image\":{\"small\":\"\"}}}]") }
  let(:collection_id) { "v_gegYsM354323" }

  before(:all) { ENV["unsplash_key"] = "super_secret_key" }
  before(:each) { allow(Faraday).to receive(:get).and_return(faraday_response) }
  after(:all) { ENV["unsplash_key"] = original_unsplash_key }

  describe "GET /collection" do
    it "calls Faraday.get to retrieve photos" do
      get collection_path, params: { collection_id: collection_id }

      expect(Faraday).to have_received(:get).with(
        "https://api.unsplash.com/collections/#{collection_id}/photos",
        nil,
        { Authorization: "Client-ID super_secret_key", "Content-Type": "application/json" }
      )
    end

    it "defines @collection_id" do
      get collection_path, params: { collection_id: collection_id }

      expect(assigns(:collection_id)).to eq(collection_id)
    end

    context "when photo collection is found" do
      it "defines @photos" do
        get collection_path, params: { collection_id: collection_id }

        expect(assigns(:photos)).to eq(JSON.parse(faraday_response.body))
      end

      it "assigns flash notice" do
        get collection_path, params: { collection_id: collection_id }

        expect(flash.now[:notice]).to eq("Collection successfully retrieved")
      end

      it "renders home/index template" do
        get collection_path, params: { collection_id: collection_id }

        expect(response).to render_template("home/index")
      end
    end

    context "when photo collection is not found" do
      let(:reason_phrase) { "Not Found" }
      let(:faraday_response) { double(status: 404, reason_phrase: reason_phrase) }

      it "assigns flash alert" do
        get collection_path, params: { collection_id: collection_id }

        expect(flash[:alert]).to eq("Unable to retrieve collection: #{reason_phrase}")
      end

      it "redirects to root_path" do
        get collection_path, params: { collection_id: collection_id }

        expect(response).to redirect_to(root_path)
      end
    end
  end
end
