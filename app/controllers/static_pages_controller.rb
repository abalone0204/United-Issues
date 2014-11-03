class StaticPagesController < ApplicationController
  def say
    @word = params[:word]
  end
end
