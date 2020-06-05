# frozen_string_literal: true

module Api
  module V1
    class ProfilesController < Api::V1::ApiController
      before_action :authenticate!

      def show
        authorize(profile)
        render jsonapi: profile, include: %w(avatar)
      end

      def update
        authorize(profile)
        Profile::SetProfileAvatarService.new(profile, avatar).process if avatar

        if profile.update(item_params)
          render jsonapi: profile,
                 include: %w(avatar),
                 status: :accepted
        else
          render jsonapi_errors: profile.errors, status: :not_acceptable
        end
      end

    private

      def item_params
        params.require(model.to_s.underscore.to_sym).permit(
          :first_name, :last_name, :phone_number, :description, :accessibility
        )
      end

      def model
        Profile
      end

      def avatar
        params['profile']['avatar']
      end

      def profile
        model.find_by!(id: params[:id])
      end
    end
  end
end
