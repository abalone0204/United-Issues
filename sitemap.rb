require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://united-issue.com'
SitemapGenerator::Sitemap.create do
  add '/', :changefreq => 'daily', :priority => 0.9
  add '/posts', :changefreq => 'daily'
end
SitemapGenerator::Sitemap.ping_search_engines