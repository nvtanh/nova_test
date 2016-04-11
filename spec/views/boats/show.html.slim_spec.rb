require 'rails_helper'

RSpec.describe "boats/show.html.slim", type: :view do
  before do
    @boat = create(:boat, name: "boat 1")
    3.times do |i|
      @boat.goods.create(name: "goods #{i}", quantity: i + 1)
    end
  end

  it "should be successful" do
    render
    controller.response.should be_success
  end

  it "display a boat" do
    assign(:boat, @boat)
    render
    expect(rendered).to match /boat 1/
  end

  it "displays all the goods of boat" do
    assign(:goods, @boat.goods)
    render
    expect(rendered).to match /goods 0/
    expect(rendered).to match /goods 1/
    expect(rendered).to match /goods 2/
  end

  it "rendering collection in a partial" do
    render partial: "goods/good.html.slim", collection: @boat.goods

    expect(rendered).to match /goods 0/
  end
end
