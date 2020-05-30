# frozen_string_literal: true

class Attachment
  class UpdateAttachmentService
    def initialize(attachment, file)
      @attachment = attachment
      @file = file
    end

    def process
      @attachment.update(file: @file)
    end
  end
end
