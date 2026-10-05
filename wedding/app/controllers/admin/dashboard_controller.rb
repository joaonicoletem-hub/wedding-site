module Admin
  class DashboardController < Admin::ApplicationController
    def show
      @sections_count = PageSection.count
      @images_count   = PageImage.count
      @pages = PageSection::PAGES
    end
  end
end
