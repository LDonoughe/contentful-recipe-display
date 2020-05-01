# frozen_string_literal: true

require 'rails_helper'
require 'pry'

describe RecipesController do
  describe '#index' do
    it 'displays entries' do
      # binding.pry
      controller = RecipesController.new
      response = controller.index
      # expect(RecipeController)
      # expect(response).to be_successful
      expect(controller.instance_variable_get('@results').length).to eq 4
    end
  end

  describe '#show' do
  end
end
