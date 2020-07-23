# frozen_string_literal: true

module Api
  module V1
    class OptionsController < Api::V1::ApiController
      before_action :authenticate!
      before_action :set_option, only: [:show, :update, :destroy]

      # GET /options
      def index
        @options = OptionPolicy::Scope.new(
          current_user, params
        ).resolve

        render jsonapi: @options
      end

      # GET /options/1
      def show
        authorize(@option)
        render jsonapi: @option
      end

      # POST /options
      def create
        authorize(Option)
        @option = current_user.options.new(option_params)

        if @option.save
          render jsonapi: @option, status: :created
        else
          render jsonapi_errors: @option.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /options/1
      def update
        authorize(@option)
        if @option.update(option_params)
          render jsonapi: @option, status: :accepted
        else
          render jsonapi_errors: @option.errors, status: :unprocessable_entity
        end
      end

      # DELETE /options/1
      def destroy
        authorize(@option)
        @option.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_option
          @option = Option.find_by!(id: params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def option_params
          params.require(:option).permit(:title, :description)
        end
    end
  end
end