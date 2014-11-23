class LibrariesController < ApplicationController
  authorize_resource :library
  before_action :find_library, only: [:show, :edit, :update, :destroy]
  def index
    @libraries = Library.search(params)
    @libraries = @libraries.page(params[:page]).per(20)
  end

  def show

  end

  def new
    @library = Library.new
  end

  def create
    @library = Library.new(library_params)
    if @library.save
      redirect_to @library
    else
      flash[:error] = "您輸入的資料有誤"
      render :new
    end
  end

  def edit

  end

  def update
    if @library.update(library_params)
      redirect_to @library
    else
      render :edit
    end
  end

  def destroy
    @library.destroy
    redirect_to libraries_path
  end

  private

  def library_params
    params.require(:library).permit(:country_classification,:original_name, :translated_name)
  end

  def find_library
    @library = Library.find(params[:id])
  end
end
