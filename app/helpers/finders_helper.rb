module FindersHelper
  def import_found_post_to_post(found_post)
    hash = {}
    hash[:title] =found_post.title
    hash[:original_author] =found_post.original_author
    hash[:country_classification] =found_post.finder.country_classification
    hash[:remote_image_url] = found_post.image
    hash[:source_date] = found_post.released_date.to_s
    hash[:source] =found_post.source
    return hash
  end
end
