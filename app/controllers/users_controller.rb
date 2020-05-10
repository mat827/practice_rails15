class UsersController < ApplicationController
before_action :authenticate_user!
before_action :corrent_user, only:[:edit,:update]
  def index
  	@users= User.all
  	@user = current_user
  	@book = Book.new
  end

  def create
  	@book = Book.new(params[:id])
  	@book.user_id =cerrent_user_id
 	if @book.save
  	redirect_to book_path(@book.id)
  else
  	@books =Book.all
  	@user = current_user
  	render :index
  end
end

  def show
  	@user = User.find(params[:id])
  	@book = Book.new
    @books = @user.books.page(params[:page]).reverse_order

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "You have updated book successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private
  def book_prams
  	prams.require(:book).permit(:title,:body)
  end

  def user_params
    params.require(:user).permit(:name,:profile,:profile_image)
  end

  def corrent_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path(current_user)
    end
  end
end
