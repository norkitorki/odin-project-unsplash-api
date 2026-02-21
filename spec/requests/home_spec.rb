require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "GET /" do
    it "should render index template" do
      get "/"

      expect(response).to render_template(:index)
    end

    it "should be root_path" do
      get root_path

      expect(response).to render_template("home/index")
    end
  end
end
