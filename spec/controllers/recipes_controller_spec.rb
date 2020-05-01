# frozen_string_literal: true

require 'rails_helper'
require 'webmock'

describe RecipesController do
  before do
    stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV['SPACE_ID']}/environments/master/entries")
      .to_return(status: 200, body: File.read('spec/fixtures/entries.json'), headers: {})
    stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV['SPACE_ID']}/environments/master/entries?sys.id=4dT8tcb6ukGSIg2YyuGEOm")
      .to_return(status: 200, body: File.read('spec/fixtures/entries_sys.json'), headers: {})
    stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV['SPACE_ID']}/environments/master/entries?sys.id=invalid")
      .to_return(status: 200, body: File.read('spec/fixtures/invalid_id.json'), headers: {})
  end

  describe '#index' do
    it 'displays entries' do
      get :index
      results = controller.instance_variable_get('@results')
      expect(results.length).to eq 4
      results.each do |recipe|
        expect(recipe.content_type.id).to eq 'recipe'
      end
    end

    context 'contentful has an issue' do
      before do
        stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV['SPACE_ID']}/environments/master/entries")
          .to_return(status: 500, body: 'error', headers: {})
        stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV['SPACE_ID']}/environments/master/entries?sys.id=4dT8tcb6ukGSIg2YyuGEOm")
          .to_return(status: 500, body: 'error', headers: {})
      end

      it 'inform users of issue' do
        get :index
        expect(response.status).to eq 200
        expect(controller.instance_variable_get('@errors')).to match 'issue'
      end
    end
  end

  describe '#show' do
    it 'displays a single entry' do
      get :show, params: { id: '4dT8tcb6ukGSIg2YyuGEOm' }
      expect(response).to be_successful
      recipe = controller.instance_variable_get('@recipe')
      expect(recipe.content_type.id).to eq 'recipe'
    end

    context 'contentful has an issue' do
      before do
        stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV['SPACE_ID']}/environments/master/entries")
          .to_return(status: 500, body: 'error', headers: {})
        stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV['SPACE_ID']}/environments/master/entries?sys.id=4dT8tcb6ukGSIg2YyuGEOm")
          .to_return(status: 500, body: 'error', headers: {})
      end

      it 'inform users of issue' do
        get :index
        expect(response.status).to eq 200
        expect(controller.instance_variable_get('@errors')).to match 'issue'
      end
    end

    context 'when an invalid id is provided' do
      it 'returns an error' do
        get :show, params: { id: 'invalid' }
        expect(response.status).to eq 200
        expect(controller.instance_variable_get('@errors')).to match 'Not Found'
      end
    end
  end
end
