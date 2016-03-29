class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Account created!"
    else
      flash[:alert] = "FAIL!!!!!"
      render :new
    end
  end

  def edit
  end

  def update
    user_params = params.require(:user).permit(:first_name, :last_name, :email)
    # @user.assign_attributes user_params
    # if @user.save(validate: false)
    if @user.update_attributes user_params
      redirect_to(auctions_path, {notice: "User updated!"})
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                  :password_confirmation)
  end
end
