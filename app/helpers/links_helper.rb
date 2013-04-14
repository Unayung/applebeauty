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
end
