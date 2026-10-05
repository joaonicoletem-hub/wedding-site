module PagesHelper
  # Render the title of a PageSection (page + name). Returns fallback when missing/empty.
  def section_title(page, name, fallback: "")
    section = PageSection[page, name]
    section&.title&.presence || fallback
  end

  # Render the body of a PageSection. Body is stored as HTML (Trix output),
  # so it is rendered raw. Returns fallback when missing/empty.
  def section_body(page, name, fallback: "")
    section = PageSection[page, name]
    (section&.body&.presence || fallback).html_safe
  end

  # Render a single PageImage (the first one for page + section) as an <img>.
  # Options: :class, :alt, :size (Active Storage variant resize_to_limit).
  # Note: :size requires libvips/ImageMagick. If unavailable, falls back to the original.
  def section_image(page, section, options = {})
    image = PageImage.for(page, section).first
    return "" unless image&.image&.attached?

    alt = options[:alt] || image.section.humanize
    cls = options[:class] || "w-full h-full object-cover"

    src =
      if options[:size]
        begin
          image.image.variant(resize_to_limit: options[:size]).processed.url
        rescue
          url_for(image.image)
        end
      else
        url_for(image.image)
      end

    tag.img(src, alt: alt, class: cls, loading: "lazy")
  end

  # Iterate over all images for a page + section (for galleries)
  def section_images(page, section, &block)
    images = PageImage.for(page, section).select { |i| i.image.attached? }
    return "" if images.empty?

    capture do
      images.each { |image| concat block.call(image) }
    end
  end

  # Does this page+section have at least one attached image?
  def has_section_image?(page, section)
    PageImage.for(page, section).any? { |i| i.image.attached? }
  end

  # ---------- Inline edit (edit-in-place) ----------
  #
  # Wraps editable content in a Turbo Frame. When the visitor is admin,
  # an "Editar" button is shown that swaps the frame with an inline form.
  #
  #   <%= editable_section("home", "save_the_date" do %>
  #     <%= section_title("home", "save_the_date") %>
  #   <% end %>
  #
  def editable_section(page, name, **options, &block)
    content = capture(&block)
    frame_id = "section_#{page}_#{name}"

    if admin?
      turbo_frame_tag(frame_id) do
        concat content
        concat inline_edit_button(page, name, frame_id)
      end
    else
      content
    end
  end

  # Inline "Editar" / "Adicionar" button (admin only)
  def inline_edit_button(page, name, frame_id)
    section = PageSection[page, name]
    label = section ? "Editar" : "Adicionar"

    if section
      link_to(label,
              edit_admin_page_section_path(section, inline: 1),
              class: "inline-edit-btn",
              data: { turbo_frame: frame_id })
    else
      link_to(label,
              new_admin_page_section_path(
                "page_section[page]" => page,
                "page_section[name]" => name,
                inline: 1
              ),
              class: "inline-edit-btn",
              data: { turbo_frame: frame_id })
    end
  end

  # Inline "Adicionar imagem" button for an image area (admin only)
  def inline_add_image_button(page, section, frame_id = nil)
    link_to("＋ Imagem",
            new_admin_page_image_path(
              "page_image[page]" => page,
              "page_image[section]" => section
            ),
            class: "inline-edit-btn",
            data: { turbo_frame: frame_id || "images_#{page}_#{section}" })
  end

  # Inline "Remover" button for a specific image (admin only)
  def inline_remove_image_button(image)
    button_to("Remover", admin_page_image_path(image),
              method: :delete, class: "inline-edit-btn",
              data: { turbo_confirm: "Remover esta imagem?" })
  end
end
