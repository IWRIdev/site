require 'shrine'
require 'sequel_workflow_presistence'
require_relative 'image_uploader'

class StaticPage < Sequel::Model
  include ImageUploader::Attachment(:image) # adds an `image` virtual attribute 
  include Workflow
  include WorkflowSequel
  workflow_column :status

end
