class Boat < ActiveRecord::Base
  has_attached_file :image, url: :set_image_url

  belongs_to :user
  has_many :goods, dependent: :destroy

  validates :name, :year, :user, :image, presence: true
  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ }

  private
  def set_image_url
    "/images/users/#{self.user_id}/boat/:basename-#{self.id}.:extension"
  end
end
