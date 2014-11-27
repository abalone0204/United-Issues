class Admin::AnnouncementsController < AdminController
  before_action :find_announcement, only: [:show, :edit, :update, :destroy]
  def index
    @announcements = Admin::Announcement.all
  end

  def show

  end

  def new
    @announcement = Admin::Announcement.new
  end

  def create
    @announcement = Admin::Announcement.new(announcement_params)
    if @announcement.save
      redirect_to @announcement
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @announcement.update(announcement_params)
      redirect_to @announcement
    else
      render :edit
    end
  end

  def destroy
    @announcement.destroy
    redirect_to admin_announcements_path
  end

  private

  def announcement_params
    params.require(:admin_announcement).permit(:title, :content, :user_id)
  end

  def find_announcement
    @announcement = Admin::Announcement.find(params[:id])
  end
end
