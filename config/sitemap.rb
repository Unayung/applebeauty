# -*- encoding : utf-8 -*-
# Set the host name for URL creation

SitemapGenerator::Sitemap.default_host = "https://unayung.cc"
SitemapGenerator::Sitemap.create do

  add "/sitemap.xml", :priority => 1, :changefreq => "daily"
  add "/", :priority => 0.7, :changefreq => "daily"

  Link.find_in_batches do |links|
    links.each do |link|
      # if link.sellable_state == "sellable"
       add link_path(link), :priority => 0.7, :changefreq => "daily", :lastmod => link.updated_at
      # end
    end
  end
end
