# frozen_string_literal: true

require 'contentful'
require 'pry'

# Recipe can be moved into a model, client helper can be a separate file
class RecipesController < ApplicationController
  def index
    # return only the recipes
    @results = client.entries.select { |entry| entry.content_type.id == 'recipe' }
  rescue Contentful::ServerError
    @errors = 'There is an issue with our service provider'
  end

  def show
    @recipe = client.entry(recipe_params['id'])
    # We shouldn't normally need the port but it would be nice if this linked properly
    @errors = "Recipe Not Found. Please try again from the recipe list: #{request.protocol + request.host}" unless @recipe
    # binding.pry
    @chef = get_chef_name(@recipe)
    @tags = get_tags(@recipe)
  rescue Contentful::ServerError
    @errors = 'There is an issue with our service provider'
  end

  private

  def client
    Contentful::Client.new(
      space: ENV['SPACE_ID'], # This is the space ID. A space is like a project folder in Contentful terms
      access_token: ENV['ACCESS_TOKEN'] # This is the access token for this space. Normally you get both ID and the token in the Contentful web app
    )
  end

  def recipe_params
    params.permit(:id)
  end

  def get_chef_name(recipe)
    recipe.chef.name
  rescue NoMethodError
    nil
  end

  def get_tags(recipe)
    recipe.tags
  rescue NoMethodError
    nil
  end
end
