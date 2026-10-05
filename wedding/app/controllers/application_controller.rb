class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :admin?

  # True when the current request carries valid admin Basic Auth credentials.
  # After the user authenticates at /admin, the browser sends the Authorization
  # header on every subsequent request to this origin, so public pages can
  # detect the admin and show inline edit buttons.
  def admin?
    return @admin if defined?(@admin)
    @admin = begin
      auth = request.authorization.to_s
      return false unless auth.present?

      scheme, value = auth.split(" ", 2)
      return false unless scheme == "Basic"

      decoded = Base64.decode64(value.to_s)
      user, pass = decoded.split(":", 2)
      user == ENV.fetch("ADMIN_USER", "admin") &&
        pass == ENV.fetch("ADMIN_PASSWORD", "change_me")
    end
  end
end
