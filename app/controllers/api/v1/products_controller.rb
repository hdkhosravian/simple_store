module Api
  module V1
    class ProductsController < Api::V1::ApiController
      before_action :authenticate!
      before_action :find_product, only: %i(show update destroy)

      def index
        authorize(Product)
        @products = Product.all.page(page_params).per(limit_params)

        render jsonapi: @products,
          include: [:image, user: [profile: [:avatar]]],
          fields: { profile: [:username, :avatar] },
          expose: {
            current_user: current_user,
          }
      end

      def show
        authorize(@product)
        render jsonapi: @product,
          include: [:image, user: [profile: [:avatar]]],
          fields: { profile: [:username, :avatar] },
          expose: {
            current_user: current_user,
          }
      end

      def create
        authorize(Product)

        result = Product::CreateService.new(current_user, product_params).process

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
        authorize(@product)

        result = Product::UpdateService.new(@product, product_params).process

        if result[:errors].nil?
          render jsonapi: @product,
            include: [:image, user: [profile: [:avatar]]],
            fields: { profile: [:username, :avatar] },
            status: :accepted
        else
          render jsonapi_errors: { detail: result[:errors] }, status: :not_acceptable
        end
      end

      def destroy
        authorize(@product)
        @product.destroy
      end

      private

      def find_product
        @product = Product.find_by!(id: params[:id])
      end

      def product_params
        params.require(:product).permit(:title, :description, :sku, :image)
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
