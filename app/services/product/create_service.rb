# frozen_string_literal: true

class Product
    class CreateService
      def initialize(current_user, params)
        @params = params
        @current_user = current_user
      end
  
      def process
        result = ::Attachment::ValidateImageTypeService.new(@params[:image]).process
  
        return result if result.present? && result[:errors].present?
  
        product = Product.new(
          title: @params[:title],
          description: @params[:description],
          sku: @params[:sku],
          user: @current_user
        )
  
        if product.save
          Attachment::CreateAttachmentService.new(product, @params[:image]).process
          render_result(true, product, nil)
        else
          render_result(false, nil, product.errors.messages)
        end
      end
  
    private
  
      def render_result(result, object, errors)
        { result: result, object: object, errors: errors }
      end
    end
  end