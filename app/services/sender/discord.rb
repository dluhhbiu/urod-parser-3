# frozen_string_literal: true

module Sender
  class Discord
    include Singleton

    def self.batch_send
      new_records = News.where(send_discord: false).order(:urod_id)
      new_records.each { |record| instance.send_record(record) }
    end

    def send_record(record)
      data = prepare(record)
      $bot.servers.each do |server|
        next if server.system_channel.nil?
        if data[:photo].present?
          $bot.send_message(server.system_channel, data[:photo])
        end
        $bot.send_message(server.system_channel, data[:text])
      end
      record.update(send_msg: true)
    end

    private

    def prepare(record)
      record.img? ? prepare_img(record) : prepare_text(record)
    end

    def prepare_img(record)
      {
        photo: record.text,
        text: "#{record.title}\n#{record.link}"
      }
    end

    def prepare_text(record)
      {
        photo: nil,
        text: "*#{record.title}*\n#{record.text}\n#{record.link}",
      }
    end
  end
end