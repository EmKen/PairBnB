class BookingsController < ApplicationController
	def new
		@booking = Listing.find(params[:listing_id]).bookings.new
		@listing = Listing.find(params[:listing_id])
	end

  def create
  	@booking = current_user.bookings.new(booking_params)
  	@booking.listing_id = params[:listing_id]
  	@listing = Listing.find(params[:listing_id])
  	if @booking.save
      redirect_to new_booking_braintree_path(@booking)
    else
    	@errors = @booking.errors.full_messages
      render 'new'
    end
  end


	private
	def booking_params
    params.require(:booking).permit(:check_in, :check_out)
  end
end
