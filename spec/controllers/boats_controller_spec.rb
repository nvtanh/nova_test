require 'rails_helper'

RSpec.describe BoatsController, type: :controller do
  login_user

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end
  end

end
