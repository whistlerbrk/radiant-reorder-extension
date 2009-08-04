module Reorder::PageExtensions
  def self.included(base)
    base.class_eval {
      acts_as_list :scope => :parent_id
      self.reflections[:children].options[:order] = "position ASC"
      before_update :check_position
    }
    
    if defined?(Page::NONDRAFT_FIELDS)
      Page::NONDRAFT_FIELDS << 'position'
    end
    
    private
      # Make sure Reorder works with CopyMove
      def check_position
        return unless parent_id_changed? && parent
        self.position = Page.find(parent_id).children.size+1
      end
    
  end
end
