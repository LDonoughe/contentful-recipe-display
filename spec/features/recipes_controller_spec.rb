# frozen_string_literal: true

require 'rails_helper'
require 'webmock'
require 'pry'

feature 'Recipe Selection' do
  before do
    stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV['SPACE_ID']}/environments/master/entries")
      .to_return(status: 200, body: File.read('spec/fixtures/entries.json'), headers: {})
    stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV['SPACE_ID']}/environments/master/entries?sys.id=4dT8tcb6ukGSIg2YyuGEOm")
      .to_return(status: 200, body: File.read('spec/fixtures/entries_sys.json'), headers: {})
    stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV['SPACE_ID']}/environments/master/entries?sys.id=invalid")
      .to_return(status: 200, body: File.read('spec/fixtures/invalid_id.json'), headers: {})
  end

  scenario "User Selects a Recipe" do
    visit '/'
    title = find('h2', text: 'White Cheddar Grilled Cheese with Cherry Preserves')
    link_containing_title = title.find(:xpath, '..')
    link_containing_title.click
    expect(page.current_path).to eq "/recipes/4dT8tcb6ukGSIg2YyuGEOm"
    expect(find('h1').text).to eq "White Cheddar Grilled Cheese with Cherry Preserves & Basil"
    expect(find('img')['src']).to eq "//images.ctfassets.net/kk2bw5ojx476/61XHcqOBFYAYCGsKugoMYK/0009ec560684b37f7f7abadd66680179/SKU1240_hero-374f8cece3c71f5fcdc939039e00fb96.jpg"
  end
end