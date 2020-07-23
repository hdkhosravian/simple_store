module Api
  module V1
    class VariationsController < Api::V1::ApiController
      before_action :authenticate!
      before_action :find_product
      before_action :find_variation, only: %i(show update destroy)

      def index
        authorize(Variation)
        @variations = @product.variations.page(page_params).per(limit_params)

        render jsonapi: @variations,
          include: [:image, user: [profile: [:avatar]]],
          fields: { profile: [:username, :avatar] },
          expose: {
            current_user: current_user,
          }
      end

      def show
        authorize(@variation)
        render jsonapi: @variation,
          include: [:image, user: [profile: [:avatar]]],
          fields: { profile: [:username, :avatar] },
          expose: {
            current_user: current_user,
          }
      end

      def create
        authorize(Variation)

        result = Variation::CreateService.new(@product, variation_params).process

        if result[:errors].nil?
          render jsonapi: result[:object],
            include: [:image, user: [profile: [:avatar]]],
            fields: { profile: [:username, :avatar] },
            status: :created
        else
          render jsonapi_errors: { detail: result[:errors] }, status: :not_acceptable
        end
      end

      def update
        authorize(@variation)

        result = Variation::UpdateService.new(@variation, variation_params).process

        if result[:errors].nil?
          render jsonapi: @variation,
            include: [:image, user: [profile: [:avatar]]],
            fields: { profile: [:username, :avatar] },
            status: :accepted
        else
          render jsonapi_errors: { detail: result[:errors] }, status: :not_acceptable
        end
      end

      def destroy
        authorize(@variation)
        @variation.destroy
      end

      private

      def find_product
        @product = Product.find_by!(id: params[:product_id])
      end

      def find_variation
        @variation = Variation.find_by!(id: params[:id])
      end

      def variation_params
        params.require(:variation).permit(:price, :quantity, :sku, :image)
      end

      def page_params
        params[:page] || 1
      end
      
      def limit_params
        params[:limit] || 5
      end
    end
  end
end
