# frozen_string_literal: true

module Api
  module V1
    class AttachmentsController < Api::V1::ApiController
      before_action :authenticate!

      def show
        send_file(
          attachment.file.path,
          disposition: 'inline',
          type: 'image/jpeg',
          x_sendfile: true,
        )
      end

      def attachment
        Attachment.find_by(id: params[:id])
      end
    end
  end
end
