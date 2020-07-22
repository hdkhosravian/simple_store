# frozen_string_literal: true

class Story
  class ValidateImageTypeService
    def initialize(params)
      @params = params
    end

    def process
      permitted_formats = %w(image/jpeg image/png image/gif image/jpg)
      file_type         = Rack::Mime.mime_type(File.extname(@params)) if @params.present?

      if permitted_formats.include?(file_type)
        render_result(true, nil, nil)
      elsif file_type.present?
        render_result(false, nil, I18n.t('api.v1.stories.errors.format'))
      end
    end

  private

    def render_result(result, object, errors)
      { result: result, object: object, errors: errors }
    end
  end
end
