require "rails_helper"

RSpec.describe CongregationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/congregations").to route_to("congregations#index")
    end

    it "routes to #new" do
      expect(:get => "/congregations/new").to route_to("congregations#new")
    end

    it "routes to #show" do
      expect(:get => "/congregations/1").to route_to("congregations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/congregations/1/edit").to route_to("congregations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/congregations").to route_to("congregations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/congregations/1").to route_to("congregations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/congregations/1").to route_to("congregations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/congregations/1").to route_to("congregations#destroy", :id => "1")
    end

  end
end
