class HomeController < ApplicationController
  layout 'home'
  def index
    @welcome = "地方的媒體素養需要升級"
  end
end
