original_unsplash_key = ENV["unsplash_key"]

shared_context "faraday double" do
  let(:faraday_response) { double(status: 200, body: "[{\"urls\":{\"small\":\"\"},\"links\":{\"html\":\"\",\"download\":\"\"},\"user\":{\"name\":\"\",\"links\":{\"html\":\"\"},\"profile_image\":{\"small\":\"\"}}}]") }

  before(:all) { ENV["unsplash_key"] = "super_secret_key" }
  before(:each) { allow(Faraday).to receive(:get).and_return(faraday_response) }
  after(:all) { ENV["unsplash_key"] = original_unsplash_key }
end
