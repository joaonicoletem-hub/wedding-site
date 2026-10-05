module Admin
  class PageSectionsController < Admin::ApplicationController
    before_action :set_section, only: %i[show edit update destroy]

    # Group sections by page, ordered by name
    def index
      @sections = PageSection.order(:page, :name).group_by(&:page)
    end

    def show
      render :show_inline, locals: { section: @section }, layout: false
    end

    def new
      @section = PageSection.new(section_params_from_query)
    end

    def edit
    end

    def create
      @section = PageSection.new(section_params)
      if @section.save
        respond_to_inline_or_redirect
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @section.update(section_params)
        respond_to_inline_or_redirect
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @section.destroy
      redirect_to admin_page_sections_path, notice: "Seção removida."
    end

    private

    def set_section
      @section = PageSection.find(params[:id])
    end

    def section_params
      params.require(:page_section).permit(:page, :name, :title, :body)
    end

    def section_params_from_query
      params.permit(:page, :name, :title, :body)
    end

    # When editing inline, render the section content (with edit button) inside
    # the matching Turbo Frame so the page updates in place. Otherwise, redirect
    # back to the admin sections list.
    def respond_to_inline_or_redirect
      if params[:inline]
        render :show_inline, locals: { section: @section }, layout: false
      else
        redirect_to admin_page_sections_path, notice: "Seção \"#{@section.name}\" salva."
      end
    end
  end
end
