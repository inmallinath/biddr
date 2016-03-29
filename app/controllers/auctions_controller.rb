class AuctionsController < ApplicationController

  def index
    @auctions = Auction.order("created_at DESC")
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new auction_params
    @auction.user = current_user
    if @auction.save
      flash[:notice] = "Auction Created Successfully"
      redirect_to auction_path(@auction)
    else
      flash[:alert] = "Auction Could not be saved"
      render :new
    end
  end

  def show
    @auction = Auction.find params[:id]
  end

  def index_user
    @auctions = current_user.auctions.order("created_at DESC")
  end

  private
  def auction_params
    params.require(:auction).permit([:title, :description, :ends_on, :reserve_price])
  end
end
