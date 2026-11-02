class Rsvp < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :attending, inclusion: { in: [true, false] }
  validates :guests_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_validation :normalize_fields

  private

  def normalize_fields
    self.name = name.to_s.strip
    self.email = email.to_s.strip.downcase
    self.message = message.to_s.strip
    self.guests_count = 0 if guests_count.blank?
    self.attending = ActiveModel::Type::Boolean.new.cast(attending) if attending.nil? || attending == ""
  end
end
