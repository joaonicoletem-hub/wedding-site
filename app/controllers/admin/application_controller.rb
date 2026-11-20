module Admin
  class ApplicationController < ::ApplicationController
    http_basic_authenticate_with(
      name: ENV.fetch("ADMIN_USER", "admin"),
      password: ENV.fetch("ADMIN_PASSWORD", "change_me"),
      realm: "Área Administrativa — Desi & João"
    )
  end
end
