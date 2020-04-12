require "spec_helper"

RSpec.describe Iwrinet::Views::ApplicationLayout, type: :view do
  let(:layout)   { Iwrinet::Views::ApplicationLayout.new({ format: :html }, "contents") }
  let(:rendered) { layout.render }

  it 'contains application name' do
    expect(rendered).to include('Iwrinet')
  end
end
