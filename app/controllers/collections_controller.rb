class CollectionsController < ApplicationController
  def show
    @collection_id = params[:collection_id]

    unsplash = UnsplashApi.new
    response = unsplash.collection_photos(@collection_id)

    if response.status == 200
      flash.now[:notice] = "Collection successfully retrieved"
      @photos_json = response.body.force_encoding("utf-8")
      @photos = JSON.parse(response.body)
      render "home/index"
    else
      redirect_to root_path, alert: "Unable to retrieve collection: #{response.reason_phrase}"
    end
  end
end
