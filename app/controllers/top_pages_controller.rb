class TopPagesController < ApplicationController
  def index
    @images = Image.all
  end
end
