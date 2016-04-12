class Boat < ActiveRecord::Base
  has_attached_file :image, url: :set_image_url

  belongs_to :user
  has_many :goods, dependent: :destroy

  validates :name, :year, :user, :image, presence: true
  validates :year, numericality: { only_integer: true ,
    greater_than_or_equal_to: 0 }
  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ }

  def owner_by?(user)
    self.user == user
  end

  private
  def set_image_url
    "/images/users/#{self.user_id}/boat/:basename-#{self.id}.:extension"
  end
end
