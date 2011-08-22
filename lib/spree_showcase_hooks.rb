class SpreeShowcaseHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_product_tabs, 'admin/showcases/showcase_tab'
end