class PageImage < ApplicationRecord
  has_one_attached :image

  validates :page, presence: true
  validates :section, presence: true
  validate  :image_is_attached, on: :create

  scope :ordered, -> { order(:position, :id) }

  def self.for(page, section)
    where(page: page, section: section).ordered
  end

  private

  def image_is_attached
    errors.add(:image, "deve estar anexada") unless image.attached?
  end
end
