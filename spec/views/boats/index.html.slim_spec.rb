require 'rails_helper'

RSpec.describe "boats/index.html.slim", type: :view do
  it "should be successful" do
    render
    controller.response.should be_success
  end
end
