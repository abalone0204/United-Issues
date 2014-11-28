class AnnouncementsController < ApplicationController
  def index
    @announcements = Announcement.all.order('created_at DESC').map{|a| a}
    @latest_announcement = @announcements.shift

  end

  def show
    @announcement = Announcement.find(params[:id])
  end
end
