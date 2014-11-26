class HuffingtonPost < ActiveRecord::Base
  def initialize(finder)
    @url = finder.url
  end
  def hello
    puts 'hello'
  end
end