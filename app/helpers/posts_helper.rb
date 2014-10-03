module PostsHelper
  def render_post_tags(post)
    post.tags.map(&:name).map { |t| link_to t, tag_path(t) }.join(', ')
  end
end
