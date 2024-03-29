class Showcase < Asset
  validate :no_attachement_errors
  has_attached_file :attachment, 
    :styles => { :large => '475x275>' },
    :default_style => :large,
    :path => "/assets/showcase/:id/:style/:basename.:extension",
    :storage => 's3',
    :s3_credentials => Rails.root.join('config', 's3.yml')
    
  belongs_to :viewable, :polymorphic => true
  acts_as_list :scope => :viewable

  # save the w,h of the original image (from which others can be calculated)
  # we need to look at the write-queue for images which have not been saved yet
  after_post_process :find_dimensions

  def find_dimensions
    temporary = attachment.queued_for_write[:original] 
    filename = temporary.path unless temporary.nil?
    filename = attachment.path if filename.blank?
    geometry = Paperclip::Geometry.from_file(filename)
    self.attachment_width  = geometry.width
    self.attachment_height = geometry.height
  end

  # if there are errors from the plugin, then add a more meaningful message
  def no_attachement_errors
    unless attachment.errors.empty?
      # uncomment this to get rid of the less-than-useful interrim messages
      # errors.clear 
      errors.add :attachment, "Paperclip returned errors for file '#{attachment_file_name}' - check ImageMagick installation or image source file."
      false
    end
  end
end