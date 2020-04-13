require 'shrine'
require 'sequel_workflow_presistence'
require_relative 'image_uploader'

class Client < Sequel::Model
  include Workflow
  include WorkflowSequel
  workflow_column :status

end
