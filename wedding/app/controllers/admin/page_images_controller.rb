module Admin
  class PageImagesController < Admin::ApplicationController
    before_action :set_image, only: %i[destroy]

    def index
      @images = PageImage.order(:page, :section, :position).group_by(&:page)
    end

    def new
      # Pre-fill from nested params: ?page_image[page]=travel&page_image[section]=gallery
      @image = PageImage.new(
        page: params.dig(:page_image, :page),
        section: params.dig(:page_image, :section),
        position: params.dig(:page_image, :position) || 0
      )
      respond_to_inline_or_render
    end

    def create
      @image = PageImage.new(image_params)
      if @image.save
        respond_to_inline_or_redirect
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @image.image.purge_later if @image.image.attached?
      @image.destroy
      redirect_to admin_page_images_path, notice: "Imagem removida."
    end

    private

    def set_image
      @image = PageImage.find(params[:id])
    end

    def image_params
      params.require(:page_image).permit(:page, :section, :position, :image)
    end

    def respond_to_inline_or_render
      if params[:inline]
        render :new_inline, locals: { image: @image }, layout: false
      else
        render :new
      end
    end

    def respond_to_inline_or_redirect
      if params[:inline]
        # Re-render the gallery frame with the new image included
        @images = PageImage.for(@image.page, @image.section)
        render partial: "gallery_inline", locals: { page: @image.page, section: @image.section }, layout: false
      else
        redirect_to admin_page_images_path, notice: "Imagem adicionada."
      end
    end
  end
end
