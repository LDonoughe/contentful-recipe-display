# frozen_string_literal: true

require 'contentful'
require 'pry'

class RecipesController < ApplicationController
  def index
    # entry = client.entry('nyancat')

    # binding.pry

    @results = []
    client.entries.each do |entry|
      @results += [entry] if entry.content_type.id == 'recipe'
    end
  end

  def show
    # ap recipe_params
    # binding.pry
    @recipe = client.entry(recipe_params['id'])
  end

  def recipe_params
    params.permit(:id)
  end

  private

  def client
    Contentful::Client.new(
      space: ENV['SPACE_ID'], # This is the space ID. A space is like a project folder in Contentful terms
      access_token: ENV['ACCESS_TOKEN'] # This is the access token for this space. Normally you get both ID and the token in the Contentful web app
    )
  end
end
