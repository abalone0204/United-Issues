module ApplicationHelper
  def tag_cloud(tags, classes)
    i = 0
    max = tags.sort_by(&:count).last
    tags.each do |tag|
      index = tag.count.to_f / max.count * (classes.size - 1)
      yield(tag, classes[index.round])
    end
  end

  def tags_cloud(tags, classes)
    
  end
end
