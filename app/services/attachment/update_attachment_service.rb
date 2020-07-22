# frozen_string_literal: true

class Attachment
  class UpdateAttachmentService
    def initialize(fileable, attachment, file)
      @attachment = attachment
      @file = file
      @fileable = fileable
    end

    def process
      if @attachment.present?
        @attachment.update(file: @file)
      elsif @file.present?
        Attachment::CreateAttachmentService.new(@fileable, @file).process
      end

      @fileable.reload
    end
  end
end
