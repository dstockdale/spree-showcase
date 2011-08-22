class Admin::ShowcasesController < Admin::ResourceController
  before_filter :load_data

  create.before :set_viewable
  update.before :set_viewable
  destroy.before :destroy_before

  def update_positions
    params[:positions].each do |id, index|
      Showcase.update_all(['position=?', index], ['id=?', id])
    end

    respond_to do |format|
     format.js  { render :text => 'Ok' }
    end
  end

  private

  def location_after_save
    admin_product_showcases_url(@product)
  end

  def load_data
    @product = Product.find_by_permalink(params[:product_id])
    @variants = @product.variants.collect do |variant|
      [variant.options_text, variant.id ]
    end
    @variants.insert(0, [I18n.t("all"), "All"])
  end

  def set_viewable
    if params[:showcase].has_key? :viewable_id
      if params[:showcase][:viewable_id] == "All"
        @showcase.viewable = @product
      else
        @showcase.viewable_type = 'Variant'
        @showcase.viewable_id = params[:showcase][:viewable_id]
      end
    else
      @showcase.viewable = @product
    end
  end

  def destroy_before
    @viewable = @showcase.viewable
  end
  
end
