class RsvpsController < ApplicationController
  def new
    @rsvp = Rsvp.new(attending: true, guests_count: 1)
  end

  def create
    @rsvp = Rsvp.new(rsvp_params)

    if @rsvp.save
      redirect_to rsvp_path, notice: "Sua confirmação foi registrada com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def rsvp_params
    params.require(:rsvp).permit(:name, :email, :attending, :guests_count, :message)
  end
end
