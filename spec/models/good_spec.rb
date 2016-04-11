require 'rails_helper'

RSpec.describe Good, type: :model do
  context 'db' do
    context 'indexes' do
      it { should have_db_index(:boat_id)}
    end

    context 'columns' do
      it { should have_db_column(:name).of_type(:string).with_options(null: false) }
      it { should have_db_column(:quantity).of_type(:integer).with_options(null: false) }
      it { should have_db_column(:boat_id).of_type(:integer).with_options(foreign_key: true) }
    end
  end

  context 'attributes' do
    it "has name" do
      expect(build(:good, name: "ball")).to have_attributes(name: "ball")
    end

    it "has quantity" do
      expect(build(:good, quantity: 1)).to have_attributes(quantity: 1)
    end

    it "has boat" do
      boat = create(:boat)
      expect(build(:good, boat: boat)).to have_attributes(boat: boat)
    end
  end

  context "validation" do
    before do
      @boat = create(:boat)
      @good = build(:good, name: "ball", quantity: 1, boat: @boat)
    end

    it "requires name" do
      expect(@good).to validate_presence_of(:name)
    end

    it "requires year" do
      expect(@good).to validate_presence_of(:quantity)
    end

    it "requires boat" do
      expect(@good).to validate_presence_of(:boat)
    end

    it "requires quantity is integer, greater than or equal '0'" do
      expect(@good).to validate_numericality_of(:quantity).only_integer
        .is_greater_than_or_equal_to(0)
    end
  end

  context 'associations' do
    it { should belong_to(:boat) }
  end
end
