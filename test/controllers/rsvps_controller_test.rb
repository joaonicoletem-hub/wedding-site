require "test_helper"

class RsvpsControllerTest < ActionDispatch::IntegrationTest
  test "should get RSVP form" do
    get rsvp_path
    assert_response :success
    assert_select "form[action='#{rsvp_path}'][method='post']"
    assert_select "input[name='rsvp[name]']"
    assert_select "input[name='rsvp[email]']"
  end

  test "should create RSVP with valid params" do
    assert_difference("Rsvp.count", 1) do
      post rsvp_path, params: {
        rsvp: {
          name: "Ana Souza",
          email: "ana@example.com",
          attending: "true",
          guests_count: 2,
          message: "Vamos celebrar!"
        }
      }
    end

    assert_redirected_to rsvp_path
    assert_equal "Sua confirmação foi registrada com sucesso!", flash[:notice]
  end

  test "should not create RSVP with invalid params" do
    assert_no_difference("Rsvp.count") do
      post rsvp_path, params: {
        rsvp: {
          name: "",
          email: "invalid-email",
          attending: "true"
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "admin RSVP list requires authentication" do
    get admin_rsvps_path
    assert_response :unauthorized
  end

  test "admin RSVP list works with valid auth" do
    Rsvp.create!(name: "Ana Souza", email: "ana@example.com", attending: true, guests_count: 2)

    get admin_rsvps_path, headers: auth_headers
    assert_response :success
    assert_select "table"
  end

  test "admin CSV export works with valid auth" do
    get export_admin_rsvps_path(format: :csv), headers: auth_headers
    assert_response :success
    assert_equal "text/csv", response.media_type
  end

  private

  def auth_headers
    { "Authorization" => ActionController::HttpAuthentication::Basic.encode_credentials(
      ENV.fetch("ADMIN_USER", "admin"),
      ENV.fetch("ADMIN_PASSWORD", "change_me")
    ) }
  end
end
