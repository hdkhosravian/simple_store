# frozen_string_literal: true

class Variation::UpdateService
  def initialize(variation, params)
    @variation  = variation
    @params = params
  end

  def process
    result = ::Attachment::ValidateImageTypeService.new(@params[:image]).process

    return result if result.present? && result[:errors].present?

    result = Attachment::UpdateAttachmentService.new(@variation, @variation.image, @params[:image]).process

    return render_result(false, nil, I18n.t('api.v1.variations.errors.not_update')) unless result

    @variation.price = @params[:price] if @params[:price].present?
    @variation.quantity = @params[:quantity] if @params[:quantity].present?
    @variation.sku = @params[:sku] if @params[:sku].present?

    if @variation.save
      render_result(true, @variation, nil)
    else
      render_result(false, nil, @variation.errors.messages)
    end
  end

private

  def render_result(result, object, errors)
    { result: result, object: object, errors: errors }
  end
end
