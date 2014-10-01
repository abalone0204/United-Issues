module ApplicationHelper
  def tags_cloud(tags)
    tags.pluck(:name)
  end
end
