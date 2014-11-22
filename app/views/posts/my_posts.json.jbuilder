json.post_info @data_arr
json.classifications @classification_titles_key
json.countries @country_titles_key

json.posts @published_posts do |post|
  json.title post.title
  json.classification post.classification
  json.country_classification post.country_classification
  json.url url_for(post)
end

json.my_posts @posts , :title, :classification, :country_classification
