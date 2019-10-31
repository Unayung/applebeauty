xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "蘋果我最美"
    xml.description "AppleBeauty"
    xml.link root_url


    xml.item do
      xml.title "#{@todays_link.title} 蘋果我最美"
      xml.description image_url(@todays_link.photos.first)
      xml.pubDate @todays_link.created_at.to_s(:rfc822)
      xml.link link_url(@todays_link)
      xml.guid link_url(@todays_link)
    end

  end
end