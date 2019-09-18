# frozen_string_literal: true

require 'httparty'
require 'nokogiri'

# class for parsing xml from a site
class Parser
  include Singleton

  XML_URL = 'http://urod.ru/xml/rss.xml'
  STOP_CONTENT = 'Смотреть новость на сайте партнеров'

  def self.parse
    Nokogiri::XML(xml_content).search('//item').map do |item|
      @item = item
      processing_item = instance.processing
      News.insert(processing_item) if processing_item.present?
    end
  end

  private

  def xml_content
    HTTParty.get(XML_URL).body
  end

  def processing
    record = { urod_id: urod_id }
    return if record[:urod_id].blank?
    return if News.where(urod_id: record[:urod_id]).present?
    return if content_encoded.text.include?(STOP_CONTENT)

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
    @item.at_xpath('content:encoded')
  end

  def html_content_encoded
    Nokogiri::HTML(content_encoded.to_html)
  end

  def text_content_encoded
    Nokogiri::HTML(content_encoded.text)
  end

  def img?
    @item.at_xpath('enclosure').present? ||
      html_content_encoded&.at('img')&.present?
  end

  def text?
    @item.at_xpath('content:encoded').text.gsub("\n", '').strip.length.positive?
  end

  def text
    doc = text_content_encoded
    doc.css('br').each do |node|
      node.replace(Nokogiri::XML::Text.new("\n", doc))
    end
    doc.text
  end

  def img
    if @item.at_xpath('enclosure').present?
      @item.at_xpath('enclosure')&.[](:url)
    elsif html_content_encoded&.at('img')&.present?
      html_content_encoded&.at('img')&.[](:src)
    else
      raise StandardError
    end
  end

  def format_and_text
    if img?
      { format: 'img', text: img }
    elsif text?
      { format: 'text', text: text }
    else
      { format: 'none', text: nil }
    end
  rescue StandardError
    { format: 'none', text: nil }
  end
end
