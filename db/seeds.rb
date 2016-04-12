p "Clear DB"
User.destroy_all

p "Create user"
user = User.create(email: "test@gmail.com", password: "12345678", password_confirmation: "12345678")

p "Create boats"
25.times do |i|
  boat = user.boats.create!(name: "boat#{i+1}", year: 2016, image: File.new(Rails.root.to_s + '/app/assets/images/test.jpg'))
  boat.goods.create!(name: "goods of boat #{boat.id}", quantity: i)
end
p "End seed"