require 'rails_helper'

RSpec.describe "Robots", type: :request do
  describe "GET /orders" do
    it "returns http success" do
      get "/robot/orders"
      expect(response).to have_http_status(:success)
    end
  end

end
