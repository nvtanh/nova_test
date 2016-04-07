include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :boat do
    name "MyString"
    year 1
    user
    image { fixture_file_upload(Rails.root.to_s + '/app/assets/images/test.jpg', 'image/jpg') }
  end
end
