module PaginationHelper
  START_PAGE = 1

  def draw_pagination items
    pagination_init items
    next_page = get_next_page
    previous_page = get_previous_page

    if @pages_count > 1
      "<nav class=\"text-right\">
          <ul class=\"pagination\">
            #{draw_paginate_button :text => '<span aria-hidden="true">&laquo;</span>'.html_safe, :page => previous_page[:page], :disabled => previous_page[:disabled]}
            #{draw_pages}
            #{draw_paginate_button :text => '<span aria-hidden="true">&raquo;</span>'.html_safe, :page => next_page[:page], :disabled => next_page[:disabled]}
          </ul>
      </nav>".html_safe
    end
  end

  private
  def draw_pages
    html = ''
    (1..@pages_count).each do |i|
      html += draw_paginate_button :text => i, :page => i, :class => (i == @current_page ? 'active' : '')
    end
    html.html_safe
  end

  private
  def draw_paginate_button args
    item_class = get_item_class(:class => args[:class], :disabled => args[:disabled])
    "<li class=\"#{item_class}\">#{link_to args[:text], get_pagination_url(args[:page])}</li>".html_safe
  end

  private
  def get_item_class args
    item_class = args[:disabled] ? 'disabled' : ''
    item_class += args[:class].blank? ? '' : ' ' + args[:class]
  end

  private
  def get_next_page
    result = {:disabled => true, :page => ''}
    if @current_page < @pages_count
      result = {:disabled => false, :page => @current_page + 1}
    end
    result
  end

  private
  def get_previous_page
    result = {:disabled => true, :page => ''}
    if @current_page > START_PAGE
      result = {:disabled => false, :page => @current_page - 1}
    end
    result
  end

  private
  def get_pagination_url page
    result = '#'
    unless page.blank?
      result = params.merge(:page => page)
    end
    result
  end

  private
  def pagination_init items
    items_per_page = ActiveRecord::Base::per_page #TODO: change this
    items_count = ActiveRecord::Base::items_count #TODO: change this
    @pages_count = items_count / items_per_page + (items_count % items_per_page > 0 ? 1 : 0)
    @current_page = params[:page].present? ? params[:page].to_i : START_PAGE
  end
end