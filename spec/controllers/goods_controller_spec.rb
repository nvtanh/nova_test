require 'rails_helper'

RSpec.describe GoodsController, type: :controller do
  login_user

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before do
        @old_amount_good = Good.count
        @boat = create(:boat)
        post :create, boat_id: @boat.id, good: attributes_for(:good)
      end

      it "create a good" do
        expect(Good.count).to eq(@old_amount_good + 1)
        expect(@boat.goods.count).to eq(1)
      end

      it "redirects to the 'boat/:id' action and flash[:success] for the new good" do
        expect(response).to redirect_to boat_path(@boat)
        flash[:success].should include(I18n.t("goods.create.success"))
      end
    end
    context 'with invalid params' do
      before do
        @old_amount_good = Good.count
        @boat = create(:boat)
        post :create, boat_id: @boat.id, good: attributes_for(:good, name: nil)
      end

      it "don't create a goods" do
        expect(Good.count).to eq(@old_amount_good)
      end

      it "render the 'new' template" do
        expect(response).to render_template(:new)
      end
    end
  end
  describe 'PUT #update' do
    context 'with valid attributes' do
      before do
        @good = create(:good)
        put :update, boat_id: @good.boat.id, id: @good.id, good: attributes_for(:good, name: "new goods")
        @good.reload
      end

      it "update a goods" do
        expect(@good.name).to eq "new goods"
      end

      it "redirects to the 'show' action and flash[:success] for the update goods" do
        expect(response).to redirect_to boat_path(@good.boat)
        flash[:success].should include(I18n.t("goods.update.success"))
      end
    end

    context 'with invalid params' do
      before do
        @good = create(:good, name: "old goods")
        post :update, boat_id: @good.boat.id, id: @good.id, good: attributes_for(:good, name: nil)
        @good.reload
      end

      it "don't update a good" do
        expect(@good.name).to eql "old goods"
      end

      it "render the 'edit' template" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      good = create(:good)
      @old_amount_good = Good.count
      delete :destroy, boat_id: good.boat.id, id: good.id
    end

    it "Destroyed successfully" do
      expect(Good.count).to eq(@old_amount_good - 1)
      flash[:success].should include(I18n.t("goods.destroy.success"))
    end
  end
end