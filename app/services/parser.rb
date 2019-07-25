# frozen_string_literal: true

require 'awesome_print'
require 'byebug'
require 'net/http'
require 'nokogiri'

# class for parsing xml from a site
class Parser
  XML_URL = 'http://urod.ru/xml/rss.xml'
  STOP_CONTENT = 'Смотреть новость на сайте партнеров'

  def parse
    Nokogiri::XML(xml_content).search('//item').map do |item|
      @item = item
      processing_item = processing
      News.insert(processing_item) if processing_item.present?
    end
  end

  private

  def xml_content
    Net::HTTP.get(URI.parse(XML_URL))
  end

  def processing
    record = { urod_id: urod_id }
    return if record[:urod_id].blank?
    return if News.where(urod_id: record[:urod_id]).present?
    return if content_encoded.to_s.include?(STOP_CONTENT)

    record[:link] = attr_content('link')
    record[:title] = attr_content('title')
    record.merge!(format_and_text)
  end

  def attr_content(attribute_name)
    @item.at_xpath(attribute_name).text
  end

  def urod_id
    attr_content('link')&.gsub(/\D/, '')&.to_i
  end

  def content_encoded
    Nokogiri::HTML(@item.at_xpath('content:encoded').to_html)
  end

  def img?
    @item.at_xpath('enclosure').present? ||
      content_encoded&.at('img')&.present?
  end

  def text?
    content_encoded&.xpath('//text()')&.to_html&.gsub('\n', '')&.strip&.length&.positive?
  end

  def img
    if @item.at_xpath('enclosure').present?
      @item.at_xpath('enclosure')&.[](:url)
    elsif content_encoded&.at('img')&.present?
      content_encoded&.at('img')&.[](:src)
    else
      raise StandardError
    end
  end

  def format_and_text
    if img?
      { format: 'img', text: img }
    elsif text?
      { format: 'text', text: content_encoded.to_html }
    else
      { format: 'none', text: nil }
    end
  rescue StandardError
    { format: 'none', text: nil }
  end
end
