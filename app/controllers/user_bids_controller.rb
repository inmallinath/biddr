class UserBidsController < ApplicationController
  before_action :authenticate_user

  def new
    @user_bid = UserBid.new
  end

  def create
    @auction = Auction.find params[:auction_id]
    @user_bid = UserBid.new bid_params
    @user_bid.user = current_user
    @user_bid.auction = @auction
    if @user_bid.save
      flash[:notice] = "Saved Successfully"
      redirect_to auction_path(@auction)
    else
      flash[:alert] = "Could not be saved"
      render :new
    end
  end

  private
  def bid_params
    params.require(:user_bid).permit([:bid_price, :bid_date])
  end
end
