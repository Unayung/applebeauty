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
    end

    name = tmp.split("<br").first
    return name
  end
end
