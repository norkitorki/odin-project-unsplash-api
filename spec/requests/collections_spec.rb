require 'rails_helper'
require_relative '../support/faraday_double'

RSpec.describe "Collections", type: :request do
  include_context 'faraday double'

  let(:collection_id) { "v_gegYsM354323" }

  describe "GET /collection" do
    it "defines @collection_id" do
      get collection_path, params: { collection_id: collection_id }

      expect(assigns(:collection_id)).to eq(collection_id)
    end

    context "when photo collection is found" do
      it "defines @photos_json" do
        get collection_path, params: { collection_id: collection_id }

        expect(assigns(:photos_json)).to eq(faraday_response.body.force_encoding("utf-8"))
      end

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
