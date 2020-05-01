# frozen_string_literal: true

require 'contentful'

class RecipesController < ApplicationController
  def index
    client = Contentful::Client.new(
    space: ENV['SPACE_ID'],  # This is the space ID. A space is like a project folder in Contentful terms
    access_token: ENV['ACCESS_TOKEN']  # This is the access token for this space. Normally you get both ID and the token in the Contentful web app
    )

# This API call will request an entry with the specified ID from the space defined at the top, using a space-specific access token.
    # entry = client.entry('nyancat')

    # require 'pry'
    # binding.pry

    @results = []
    client.entries.each do |entry|
      @results += [entry] if entry.content_type.id == 'recipe'
    end
  end

  def show; end
end
