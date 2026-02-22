class CollectionsController < ApplicationController
  def show
    api_key = ENV["unsplash_key"]
    @collection_id = params[:collection_id]

    response = get_response(api_key, @collection_id)

    if response.status == 200
      flash.now[:notice] = "Collection successfully retrieved"
      @photos = JSON.parse(response.body)
      render "home/index"
    else
      redirect_to root_path, alert: "Unable to retrieve collection: #{response.reason_phrase}"
    end
  end

  private

  def get_response(api_key, collection_id)
    Faraday.get(
      "https://api.unsplash.com/collections/#{collection_id}/photos",
      nil,
      {
        Authorization: "Client-ID #{api_key}",
        "Content-Type": "application/json"
      }
    )
  end
end
