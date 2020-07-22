# frozen_string_literal: true

class Story::UpdateService
  def initialize(story, params)
    @story  = story
    @params = params
  end

  def process
    result = ::Story::ValidateImageTypeService.new(@params[:image]).process

    return result if result.present? && result[:errors].present?

    result = Attachment::UpdateAttachmentService.new(@story, @story.image, @params[:image]).process

    return render_result(false, nil, I18n.t('api.v1.stories.errors.not_update')) unless result

    @story.body = @params[:body] if @params[:body].present?
    @story.latitude = @params[:latitude] if @params[:latitude].present?
    @story.longitude = @params[:longitude] if @params[:longitude].present?

    if @story.save
      render_result(true, @story, nil)
    else
      render_result(false, nil, @story.errors.messages)
    end
  end

private

  def render_result(result, object, errors)
    { result: result, object: object, errors: errors }
  end
end
