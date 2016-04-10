require 'rails_helper'

RSpec.describe BoatsController, type: :controller do
  login_user

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end

  describe "GET #index" do
    before { get :index }
    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns @boats" do
      boat = create(:boat, user: subject.current_user)
      expect(assigns(:boats)).to eq([boat])
    end

    it { expect(response).to render_with_layout :application }
    it { should render_template :index }
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before do
        @old_amount_boat = Boat.count
        post :create, boat: attributes_for(:boat)
      end

      it "create a boat" do
        expect(Boat.count).to eq(@old_amount_boat + 1)
      end

      it "redirects to the 'index' action and flash[:success] for the new boat" do
        expect(response).to redirect_to boats_path
        flash[:success].should include(I18n.t("boats.create.success"))
      end
    end
    context 'with invalid params' do
      before do
        @old_amount_boat = Boat.count
        post :create, boat: attributes_for(:boat, name: nil)
      end

      it "don't create a boat" do
        expect(Boat.count).to eq(@old_amount_boat)
      end

      it "redirects to the 'index' action and flash[:errors] for the new boat" do
        expect(response).to redirect_to boats_path
      end
    end
  end

  describe 'POST #update' do
    context 'with valid attributes' do
      before do
        @boat = create(:boat)
        put :update, id: @boat.id, boat: attributes_for(:boat, name: "new boat")
        @boat.reload
      end

      it "update a boat" do
        expect(@boat.name).to eq "new boat"
      end

      it "redirects to the 'index' action and flash[:success] for the update boat" do
        expect(response).to redirect_to boats_path
        flash[:success].should include(I18n.t("boats.update.success"))
      end
    end

    context 'with invalid params' do
      before do
        @boat = create(:boat, name: "old boat")
        post :update, id: @boat.id, boat: attributes_for(:boat, name: nil)
        @boat.reload
      end

      it "don't update a boat" do
        expect(@boat.name).to eql "old boat"
      end

      it "redirects to the 'index' action and flash[:errors] for the new boat" do
        expect(response).to redirect_to boats_path
      end
    end
  end

  describe 'POST #destroy' do
    before do
      boat = create(:boat)
      @old_amount_boat = Boat.count
      delete :destroy, id: boat.id
    end

    it "Destroyed successfully" do
      expect(Boat.count).to eq(@old_amount_boat - 1)
      flash[:success].should include(I18n.t("boats.destroy.success"))
    end
  end
end
