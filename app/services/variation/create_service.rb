# frozen_string_literal: true

class Variation
    class CreateService
      def initialize(product, params)
        @params = params
        @product = product
      end
  
      def process
        result = ::Attachment::ValidateImageTypeService.new(@params[:image]).process
  
        return result if result.present? && result[:errors].present?
  
        variation = Variation.new(
          price: @params[:price],
          quantity: @params[:quantity],
          sku: @params[:sku],
          product: @product
        )
  
        if variation.save
          Attachment::CreateAttachmentService.new(variation, @params[:image]).process
          create_options(variation)
          render_result(true, variation, nil)
        else
          render_result(false, nil, variation.errors.messages)
        end
      end
  
    private
  
      def render_result(result, object, errors)
        { result: result, object: object, errors: errors }
      end

      def create_options(variation)
        @params[:option_ids]&.each do |option_id|
          VariationOption.create(variation: variation, option_id: option_id)
        end
      end
    end
  end