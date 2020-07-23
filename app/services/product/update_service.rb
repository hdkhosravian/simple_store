# frozen_string_literal: true

class Product::UpdateService
  def initialize(product, params)
    @product  = product
    @params = params
  end

  def process
    result = ::Attachment::ValidateImageTypeService.new(@params[:image]).process

    return result if result.present? && result[:errors].present?

    result = Attachment::UpdateAttachmentService.new(@product, @product.image, @params[:image]).process

    return render_result(false, nil, I18n.t('api.v1.products.errors.not_update')) unless result

    @product.title = @params[:title] if @params[:title].present?
    @product.description = @params[:description] if @params[:description].present?
    @product.sku = @params[:sku] if @params[:sku].present?

    if @product.save
      render_result(true, @product, nil)
    else
      render_result(false, nil, @product.errors.messages)
    end
  end

private

  def render_result(result, object, errors)
    { result: result, object: object, errors: errors }
  end
end
