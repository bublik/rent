require 'spec_helper'

describe RentersController do

  let(:user) { FactoryGirl.create(:user) }
  let(:valid_attributes) { {user_id: user.id, "phone" => "8909305070663", email: 'mail@gg.com', town: 'Odessa', rooms: '1', amount: 100, guard_time: DateTime.tomorrow } }

  before(:each) do
    sign_in user
  end

  describe "GET index" do
    it "assigns all renters as @renters" do
      renter = Renter.create! valid_attributes
      get :index, {}
      assigns(:renters).should eq([renter])
    end
  end

  describe "GET show" do
    it "assigns the requested renter as @renter" do
      renter = Renter.create! valid_attributes
      get :show, {:id => renter.to_param}
      assigns(:renter).should eq(renter)
    end
  end

  describe "GET new" do
    it "assigns a new renter as @renter" do
      get :new, {}
      assigns(:renter).should be_a_new(Renter)
    end
  end

  describe "GET edit" do
    it "assigns the requested renter as @renter" do
      renter = Renter.create! valid_attributes
      get :edit, {:id => renter.to_param}
      assigns(:renter).should eq(renter)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Renter" do
        expect {
          post :create, {:renter => valid_attributes}
        }.to change(Renter, :count).by(1)
      end

      it "assigns a newly created renter as @renter" do
        post :create, {:renter => valid_attributes}
        assigns(:renter).should be_a(Renter)
        assigns(:renter).should be_persisted
      end

      it "redirects to the created renter" do
        post :create, {:renter => valid_attributes}
        response.should redirect_to(Renter.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved renter as @renter" do
        # Trigger the behavior that occurs when invalid params are submitted
        Renter.any_instance.stub(:save).and_return(false)
        post :create, {:renter => {"phone" => "invalid value"}}
        assigns(:renter).should be_a_new(Renter)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Renter.any_instance.stub(:save).and_return(false)
        post :create, {:renter => {"phone" => "invalid value"}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested renter" do
        renter = Renter.create! valid_attributes
        # Assuming there are no other renters in the database, this
        # specifies that the Renter created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Renter.any_instance.should_receive(:update).with({"phone" => "MyString"})
        put :update, {:id => renter.to_param, :renter => {"phone" => "MyString"}}
      end

      it "assigns the requested renter as @renter" do
        renter = Renter.create! valid_attributes
        put :update, {:id => renter.to_param, :renter => valid_attributes}
        assigns(:renter).should eq(renter)
      end

      it "redirects to the renter" do
        renter = Renter.create! valid_attributes
        put :update, {:id => renter.to_param, :renter => valid_attributes}
        response.should redirect_to(renter)
      end
    end

    describe "with invalid params" do
      it "assigns the renter as @renter" do
        renter = Renter.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Renter.any_instance.stub(:save).and_return(false)
        put :update, {:id => renter.to_param, :renter => {"phone" => "invalid value"}}
        assigns(:renter).should eq(renter)
      end

      it "re-renders the 'edit' template" do
        renter = Renter.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Renter.any_instance.stub(:save).and_return(false)
        put :update, {:id => renter.to_param, :renter => {"phone" => "invalid value"}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested renter" do
      renter = Renter.create! valid_attributes
      expect {
        delete :destroy, {:id => renter.to_param}
      }.to change(Renter, :count).by(-1)
    end

    it "redirects to the renters list" do
      renter = Renter.create! valid_attributes
      delete :destroy, {:id => renter.to_param}
      response.should redirect_to(renters_url)
    end
  end

end
