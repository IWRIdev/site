require 'shrine'
require 'sequel_workflow_presistence'
require_relative 'image_uploader'

class ImageFile < Sequel::Model
  include ImageUploader::Attachment(:image) # adds an `image` virtual attribute 
  include Workflow
  include WorkflowSequel
  workflow_column :status

  workflow do
    state :uploading do
      event :uploaded, :transition_to => :processing
    end

    state :processing do
      event :processed, :transition_to => :hidden
    end

    state :hidden do
      event :publish, :transition_to => :active
      event :reload, :transition_to => :processing
      event :zap, :transition_to => :deleted
    end

    state :active do
      event :hide, :transition_to => :hidden
      event :zap, :transition_to => :deleted
    end

    state :deleted
  end
end
