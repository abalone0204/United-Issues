require "huffingtonpost"
require "mezhdunarodnaya"
require "dw"


class Mantis
  attr_accessor :url
  attr_accessor :data
  include HuffingtonPost
  include Hezhdunarodnaya
  include DW
  
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
    elsif @url == "http://www.dw.de"
      result = dw_scraping(@data, @url)
    end

    return result
  end

  def simple_strip(text)
      return text.strip.gsub(/\t/,"").gsub(/\n/, " ")
  end



end