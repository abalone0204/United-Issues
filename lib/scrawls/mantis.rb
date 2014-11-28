require "huffingtonpost"
require "mezhdunarodnaya"
require "dw"
require "sabah"
require "newsis"

class Mantis
  attr_accessor :url
  attr_accessor :data
  include HuffingtonPost
  include Hezhdunarodnaya
  include DW
  include Sabah
  include NewsIs
  
  def initialize(finder)
    @url = finder.site_url
    @data = Nokogiri::HTML(open(@url))
  end

  def scraping_result
    result= []
    if @url == "http://www.huffingtonpost.jp"
      result = huffington_scraping(@data)
    elsif @url == "http://itar-tass.com/mezhdunarodnaya-panorama"
      result = mezhdunarodnaya_scraping(@data, @url)
    elsif @url == "http://www.dw.de/themen/s-9077"
      result = dw_scraping(@data, @url)
    elsif @url == "http://www.sabah.com.tr"
    elsif @url == "http://www.newsis.com"
      result = newsis_scraping(@data, @url)
    end

    return result
  end

  def simple_strip(text)
      return text.strip.gsub(/\t/,"").gsub(/\n/, " ")
  end



end