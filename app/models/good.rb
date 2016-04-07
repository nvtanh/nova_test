class Good < ActiveRecord::Base
  belongs_to :boat

  validates :name, :quantity, :boat, presence: true
end
