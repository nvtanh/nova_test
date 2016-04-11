require 'rails_helper'

RSpec.describe "boats/index.html.slim", type: :view do
  before do
    boat = create(:boat)
    assign(:boats, Kaminari.paginate_array([boat]).page(1))
  end

  it "should be successful" do
    render
    controller.response.should be_success
  end

  it "should show a table" do
    render
    rendered.should have_selector("table")
  end
end
