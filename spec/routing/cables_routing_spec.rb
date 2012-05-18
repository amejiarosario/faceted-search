require "spec_helper"

describe CablesController do
  describe "routing" do

    it "routes to #index" do
      get("/cables").should route_to("cables#index")
    end

    it "routes to #new" do
      get("/cables/new").should route_to("cables#new")
    end

    it "routes to #show" do
      get("/cables/1").should route_to("cables#show", :id => "1")
    end

    it "routes to #edit" do
      get("/cables/1/edit").should route_to("cables#edit", :id => "1")
    end

    it "routes to #create" do
      post("/cables").should route_to("cables#create")
    end

    it "routes to #update" do
      put("/cables/1").should route_to("cables#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/cables/1").should route_to("cables#destroy", :id => "1")
    end

  end
end
