class PageSection < ApplicationRecord
  validates :page, presence: true
  validates :name, presence: true, uniqueness: { scope: :page }

  PAGES = %w[home info travel].freeze

  def self.[](page, name)
    find_by(page: page, name: name)
  end

  def display_page
    page.humanize
  end
end
