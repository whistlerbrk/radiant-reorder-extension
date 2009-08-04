module Reorder::PageHelper
  def order_links(page)
    returning String.new do |output|
      output << link_to(image("move_to_top.png", :alt => "Move to top"), move_to_top_admin_page_path(page), :method => :put)
      output << link_to(image("move_higher.png", :alt => "Move up"), move_higher_admin_page_path(page), :method => :post)
      output << link_to(image("move_lower.png", :alt => "Move down"), move_lower_admin_page_path(page), :method => :post)
      output << link_to(image("move_to_bottom.png", :alt => "Move to bottom"), move_to_bottom_admin_page_path(page), :method => :put)
    end
  end
end