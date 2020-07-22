# frozen_string_literal: true

module Api
  module V1
    class ProfilesController < Api::V1::ApiController
      before_action :authenticate!
      before_action :find_profile

      def show
        authorize(@profile)
        render jsonapi: @profile, include: %w(avatar)
      end

      def update
        authorize(@profile)
        Profile::SetProfileAvatarService.new(@profile, avatar).process if avatar

        if @profile.update(item_params)
          render jsonapi: @profile,
                 include: %w(avatar),
                 status: :accepted
        else
          render jsonapi_errors: @profile.errors, status: :not_acceptable
        end
      end

    private

      def item_params
        params.require(:profile).permit(
          :username, :description
        )
      end

      def avatar
        params['profile']['avatar']
      end

      def find_profile
        @profile = Profile.find_by!(id: params[:id])
      end
    end
  end
end
