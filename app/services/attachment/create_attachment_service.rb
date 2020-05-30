# frozen_string_literal: true

class Attachment
  class CreateAttachmentService
    def initialize(fileable, file)
      @fileable = fileable
      @file = file
    end

    def process
      Attachment.create(fileable: @fileable, file: @file)
    end
  end
end
