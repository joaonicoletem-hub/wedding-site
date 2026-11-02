require "csv"

module Admin
  class RsvpsController < Admin::ApplicationController
    def index
      @rsvps = Rsvp.order(created_at: :desc)
    end

    def export
      @rsvps = Rsvp.order(created_at: :desc)
      csv_string = CSV.generate(headers: true) do |csv|
        csv << ["nome", "email", "presença", "convidados", "mensagem", "criado_em"]

        @rsvps.each do |rsvp|
          csv << [
            rsvp.name,
            rsvp.email,
            rsvp.attending ? "Sim" : "Não",
            rsvp.guests_count,
            rsvp.message.presence || "",
            rsvp.created_at.strftime("%d/%m/%Y %H:%M")
          ]
        end
      end

      send_data csv_string, filename: "rsvps-#{Date.current}.csv", type: "text/csv; charset=utf-8"
    end
  end
end
