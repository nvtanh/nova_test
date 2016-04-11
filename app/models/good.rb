class Good < ActiveRecord::Base
  belongs_to :boat

  validates :name, :quantity, :boat, presence: true
  validates :quantity, numericality: { only_integer: true,
    greater_than_or_equal_to: 0 }
end
