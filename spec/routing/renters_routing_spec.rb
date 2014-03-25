require "spec_helper"

describe RentersController do
  describe "routing" do

    it "routes to #index" do
      get("/renters").should route_to("renters#index")
    end

    it "routes to #new" do
      get("/renters/new").should route_to("renters#new")
    end

    it "routes to #show" do
      get("/renters/1").should route_to("renters#show", :id => "1")
    end

    it "routes to #edit" do
      get("/renters/1/edit").should route_to("renters#edit", :id => "1")
    end

    it "routes to #create" do
      post("/renters").should route_to("renters#create")
    end

    it "routes to #update" do
      put("/renters/1").should route_to("renters#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/renters/1").should route_to("renters#destroy", :id => "1")
    end

  end
end
