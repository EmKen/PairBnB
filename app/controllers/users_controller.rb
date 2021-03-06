class UsersController < Clearance::UsersController

	def new
    @user = User.new
    render template: "users/new"
  end

  def create
    @user = User.new(user_from_params)
    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      @errors = @user.errors.full_messages
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_from_params)
    if @user.save
      redirect_back_or url_after_create
    else
      @errors = @user.errors.full_messages
      respond_to do |format|
        format.js { render "update.js.erb"}
      end
      # redirect_to "/"
    end
  end

  def username
    @user = User.find(params[:id])
  end

  private

  def user_from_params
		params.require(:user).permit(:first_name, :last_name, :username, :dob, :email, :password, :avatar, :remote_avatar_url)
  end


end