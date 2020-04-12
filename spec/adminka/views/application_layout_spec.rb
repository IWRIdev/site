require "spec_helper"

RSpec.describe Adminka::Views::ApplicationLayout, type: :view do
  let(:layout)   { Adminka::Views::ApplicationLayout.new({ format: :html }, "contents") }
  let(:rendered) { layout.render }

  it 'contains application name' do
    expect(rendered).to include('Adminka')
  end
end
