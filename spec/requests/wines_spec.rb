require 'rails_helper'

RSpec.describe "Wines", :type => :request do
  describe "GET /wines" do
    it "works! (now write some real specs)" do
      get wines_path
      expect(response.status).to be(200)
    end
  end
end
