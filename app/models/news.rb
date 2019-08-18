# frozen_string_literal: true

class News < Sequel::Model
  include WithCreatedAt

  plugin :validation_helpers

  ALLOWED_FORMATS = %w[img text none].freeze

  def validate
    super
    validates_includes(ALLOWED_FORMATS, :format)
  end

  def img?
    self.format == 'img'
  end
end
