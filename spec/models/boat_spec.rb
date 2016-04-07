require 'rails_helper'

RSpec.describe Boat, type: :model do
  context "db" do
    context "indexes" do
      it { should have_db_index(:user_id) }
    end

    context "columns" do
      it { should have_db_column(:name).of_type(:string).with_options(null: false) }
      it { should have_db_column(:year).of_type(:integer).with_options(null: false) }
      it { should have_db_column(:user_id).of_type(:integer).with_options(foreign_key: true) }
      it { should have_attached_file(:image) }
    end
  end

  context "attributes" do
    it "has name" do
      expect(build(:boat, name: "nvtanh")).to have_attributes(name: "nvtanh")
    end

    it "has year" do
      expect(build(:boat, year: 2016)).to have_attributes(year: 2016)
    end

    it "has user" do
      user = create(:user)
      expect(build(:boat, user: user)).to have_attributes(user: user)
    end
  end

  context "validation" do
    before do
      @user = create(:user)
      @boat = build(:boat, name: "nvtanh", year: 2016, user: @user)
    end

    it "requires name" do
      expect(@boat).to validate_presence_of(:name)
    end

    it "requires year" do
      expect(@boat).to validate_presence_of(:year)
    end

    it "requires user" do
      expect(@boat).to validate_presence_of(:user)
    end

    it "requires image" do
      should validate_attachment_presence(:image)
    end

    it "requires content type of image" do
      should validate_attachment_content_type(:image).allowing("image/jpg")
    end
  end

  context 'associations' do
    it { should belong_to(:user) }
  end
end
