module Admin
  class ApplicationController < ::ApplicationController
    layout "admin/application"

    http_basic_authenticate_with(
      name: ENV.fetch("ADMIN_USER", "admin"),
      password: ENV.fetch("ADMIN_PASSWORD", "change_me"),
      realm: "Área Administrativa — Desi & João"
    )

    protected

    def default_url_options
      { host: request.host, port: request.port }
    end
  end
end
