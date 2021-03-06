class AuctionsController < ApplicationController
  before_action :authenticate_user, except: [:index]

  def index
    @auctions = Auction.order("created_at DESC").published
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

  def publish_state
    @auction = Auction.find(params[:id])
    @auction.publish
    @auction.save
    # @auction.update_attribute(:aasm_state, "Published")
   redirect_to auctions_path
  end

  def show
    @auction = Auction.find params[:id]
    @user_bid = UserBid.new
  end

  def index_user
    @auctions = current_user.auctions.order("created_at DESC")
  end

  private
  def auction_params
    params.require(:auction).permit([:title, :description, :ends_on, :reserve_price, :aasm_state])
  end


end
