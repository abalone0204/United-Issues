require "huffingtonpost"
require "mezhdunarodnaya"
require "dw"
require "sabah"
require "hani"
require "spiegel"


class Mantis
  attr_accessor :url
  attr_accessor :data
  include HuffingtonPost
  include Hezhdunarodnaya
  include DW
  include Sabah
  include Hani
  include Spiegel
  
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
      result = sabah_scraping(@data, @url)
    elsif @url =="http://www.hani.co.kr"
      result= hani_scraping(@data, @url)
    elsif @url == "http://www.spiegel.de"
      result = spiegel_scraping(@data, @url)
    end

    return result
  end

  def simple_strip(text)
      return text.strip.gsub(/\t/,"").gsub(/\n/, " ")
  end



end