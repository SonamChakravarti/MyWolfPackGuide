class Flyer < ActiveRecord::Base
  mount_uploader :image, ImageUploader
end
