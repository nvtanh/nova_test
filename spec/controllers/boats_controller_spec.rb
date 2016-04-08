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
end
