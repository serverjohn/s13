require 'rails_helper'

RSpec.describe "Congregations", type: :request do
  describe "GET /congregations" do
    it "works! (now write some real specs)" do
      get congregations_path
      expect(response).to have_http_status(200)
    end
  end
end
