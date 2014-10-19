class HomeController < ApplicationController
  layout 'home'
  def index
    @welcome = "United Issues"
  end
end
