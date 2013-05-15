# -*- encoding : utf-8 -*-
module LinksHelper

  def render_link_date(link)
    link.title
  end

  def render_link_girl_name(link)
    if link.detail.index("暱稱：")
      tmp = link.detail.split("暱稱：").second
    elsif link.detail.index("本名：")
      tmp = link.detail.split("本名：").second
    elsif link.detail.index("姓名：")
      tmp = link.detail.split("姓名：").second
    else
      tmp = "神祕路人<br"
    end

    name = tmp.split("<br").first
    return name
  end

  def render_next_link
    s = ""
    s += content_tag(:i, "",:class => "icon-arrow-left")
    s += " 後一天"
    link_to(s.html_safe, @previous, :class => "btn left")
    # s.html_safe
  end

  def render_prev_link
    s = ""
    s += "前一天 "
    s += content_tag(:i, "",:class => "icon-arrow-right")
    link_to(s.html_safe, @next, :class => "btn right")

  end

  def render_link_title(link)
    if link.link_type == "daily"
      "今天我最美 #{link.title.gsub(/[^0-9]/, '')}"
    else
      "運動靚妹 #{link.title.gsub(/[^0-9]/, '')}"
    end
  end

  def render_link_photos_for_slide(link)
    if link.photos.present?
      s = ""

      link.photos.each do |photo|
        if photo == link.photos.first
          s += content_tag(:div, :class => "item active") do
            link_to(photo.file.url, :data => { :colorbox => true }) do
              image_tag(photo.file)
            end
          end
        else
          s += content_tag(:div, :class => "item") do
            link_to(photo.file.url, :data => { :colorbox => true }) do
              image_tag(photo.file)
            end
          end
        end
      end

      return s.html_safe
    else
      content_tag(:div, :class => "item active") do
        image_tag("/images/760x420.gif")
      end
    end
  end
end