Spree::ProductsController.class_eval do

  helper_method :sorting_param
  alias_method :old_index, :index

  def index
    old_index # Like calling super: http://stackoverflow.com/a/13806783/73673
    @products = @products.send(sorting_scope)
  end

  def sorting_param
    params[:sorting].try(:to_sym) || default_sorting
  end

  private

  def sorting_scope
    allowed_sortings.include?(sorting_param) ? sorting_param : default_sorting
  end

  def default_sorting
    :ascend_by_updated_at
  end

  def allowed_sortings
    #Spree::Product.search_scopes # We could use all the sortings available in the Spree scopes.
    [:descend_by_master_price, :ascend_by_master_price, :ascend_by_updated_at]
  end


end