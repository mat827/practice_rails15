class BooksController < ApplicationController
  def index
  	@book =Book.new
  	@books = Book.all
  	@user = current_user
  end

  def create
  	@book = Book.new(book_params)
  	@book.user_id =current_user.id
  	if @book.save
  		redirect_to book_path(@book.id)
  		flash[:success]= 'Book was successfully created.'
  	else
  		@books = Book.all
  		@user = current_user
  		render :index
  	end
  end


  def show
  	@book_new =Book.new
  	@book = Book.find(params[:id])
  	@user = @book.user
  end

  def edit
  	@book = Book.find(params[:id])
      if user_signed_in? && current_user.id == @book.user_id
        render :edit
      else
        redirect_to books_path
      end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book)
    flash[:success] = "You have updated book successfully."
    else
    render :edit
    end
  end

  def destroy
      book = Book.find(params[:id])
      book.destroy
      redirect_to books_path

  end

  private
  def user_params
    params.require(:user).permit(:username,:profile,:profile_image)

  end
  def book_params
  	params.require(:book).permit(:title, :body,:user_id)
  end
end
