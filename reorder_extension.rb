# Uncomment this if you reference any of your controllers in activate
require_dependency 'application_controller'

class ReorderExtension < Radiant::Extension
  version "0.2.0"
  description "Allows (re)ordering of pages in the page tree."
  url "http://dev.radiantcms.org/"
  
  define_routes do |map|
    map.namespace :admin do |admin|
      admin.resources :pages, :member => {
        :move_higher => :post,
        :move_lower => :post,
        :move_to_top => :put,
        :move_to_bottom => :put
      }
    end
  end
  
  def activate
    admin.page.index.add :sitemap_head, "order_header"
    admin.page.index.add :node, "order"
    admin.page.index.add :top, 'header'
    Page.send :include, Reorder::PageExtensions
    Admin::PagesController.send :include, Reorder::PagesControllerExtensions
    Admin::PagesController.send :helper, Reorder::PageHelper
    StandardTags.send :include, Reorder::TagExtensions
  end
  
  def deactivate
  end
  
end
