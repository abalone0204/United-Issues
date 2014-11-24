class Admin::FindersController < AdminController
  before_action :get_finder, only: [:show, :edit, :destroy, :update]

  def index
    @finders = Admin::Finder.all
  end

  def new
    @finder = Admin::Finder.new
  end

  def create
    @finder = Admin::Finder.new(finder_params)
    if @finder.save
      check_country(@finder)
      redirect_to @finder
    else
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if @finder.update(finder_params)
      redirect_to @finder
    else
      render :edit
    end
  end

  def destroy
    @finder.destroy
    redirect_to admin_finders_path 
  end

  private
  def get_finder
    @finder = Admin::Finder.find(params[:id])
  end

  def check_country(finder)
    if finder.site_url.end_with?(".jp")
      finder.update_attribute(:country_classification, 'Japan')  
    end
  end

  def finder_params
    params.require(:admin_finder).permit(:site_name, :site_url, :available)
  end
end
