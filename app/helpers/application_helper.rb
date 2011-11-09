# -*- encoding : utf-8 -*-
module ApplicationHelper
  def title
    base_title = "새로운 펜션 검색, 레스티"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def header
    if @title.nil?
      link_to image_tag('mobile/header_logo.png'), root_url
    else
      content_tag :span, @title
    end
  end
  
  def merge_facility(id)
    if params[:facilities]
      params.merge(:facilities => params[:facilities].split(',').push(id).join(','))
    else
      params.merge(:facilities => id)
    end
  end
  
  def remove_facility(id)
    temp = params[:facilities].split(',')
    temp.delete(id.to_s)
    params.merge(:facilities => temp.join(','))
  end
end
