# frozen_string_literal: true

require 'httparty'

module Sender
  class Telegram
    include Singleton

    def self.batch_send
      new_records.each { |record| instance.send_record(record) }
    end

    def send_record(record)
      data = prepare(record)
      data[:data][:chat_id] = ENV['CHAT_ID']
      url = Sender::TELEGRAM_API + data[:action]
      response = HTTParty.post(url, body: data[:data])
      record.update(send_msg: true) if response.code == 200
    end

    private

    def prepare(record)
      record.img? ? prepare_img(record) : prepare_text(record)
    end

    def prepare_img(record)
      {
        action: 'sendPhoto',
        data: {
          photo: record.text,
          caption: "#{record.title}\n#{record.link}"
        }
      }
    end

    def prepare_text(record)
      {
        action: 'sendMessage',
        data: {
          text: "*#{record.title}*\n#{record.text}\n#{record.link}",
          parse_mode: 'markdown'
        }
      }
    end
  end
end