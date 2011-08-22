Product.class_eval do
  has_many :showcases, :as => :viewable, :order => :position, :dependent => :destroy
end