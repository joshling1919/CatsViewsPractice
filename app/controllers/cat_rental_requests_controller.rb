class CatRentalRequestsController < ApplicationController
  def new
    @cat_rental_request = CatRentalRequest.new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(rental_params)
    if @cat_rental_request.save!
      redirect_to cat_url(rental_params[:cat_id])
    else
      render @cat_rental_request.errors.full_messages
    end
  end

  def approve
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
    if @cat_rental_request.approve!
      redirect_to cat_url(@cat_rental_request[:cat_id])
    else
      render @cat_rental_request.errors.full_messages
    end
  end

  def deny
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
    @cat_rental_request.deny!
    redirect_to cat_url(@cat_rental_request[:cat_id])
  end

  private
  def rental_params
    params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id, :status)
  end
end
