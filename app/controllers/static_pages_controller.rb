class StaticPagesController < ApplicationController
  
  def say
    @word = params[:word]
  end

  def help
    
  end

  def car
    @number = params[:number].to_i 
    if params[:howdouturnthison].present? && params[:howdouturnthison] == "how do you turn this on"
      redirect_to car_path(@number+1) 
    end
  end
end
