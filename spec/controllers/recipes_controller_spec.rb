# frozen_string_literal: true

require 'rails_helper'
require 'pry'

describe RecipesController do
  describe '#index' do
    it 'displays entries' do
      # binding.pry
      # response = controller.index
      get :index
      # expect(RecipeController)
      # expect(response).to be_successful
      expect(controller.instance_variable_get('@results').length).to eq 4
    end
  end

  describe '#show' do
    it 'displays a single entry' do
      get :show, params: {id: '4dT8tcb6ukGSIg2YyuGEOm'}
      expect(response).to be_successful
      # response = controller.show(id: '4dT8tcb6ukGSIg2YyuGEOm')
    end
  end
end
