module Api
  module V1
    class StoriesController < Api::V1::ApiController
      before_action :authenticate!
      before_action :find_story, only: %i(show update destroy)

      def index
        param! :latitude, String, required: true, blank: false
        param! :longitude, String, required: true, blank: false
        param! :distance, String, required: true, blank: false

        authorize(Story)

        @stories = Story.near(
          [params[:latitude], params[:longitude]],
          params[:distance], units: :km
        ).page(page_params).per(limit_params)

        render jsonapi: @stories,
          include: [:image, user: [profile: [:avatar]]],
          fields: { profile: [:username, :avatar] },
          expose: {
            current_user: current_user,
          }
      end

      def show
        authorize(@story)
        render jsonapi: @story,
          include: [:image, user: [profile: [:avatar]]],
          fields: { profile: [:username, :avatar] },
          expose: {
            current_user: current_user,
          }
      end

      def create
        authorize(Story)

        result = Story::CreateService.new(current_user, story_params).process

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
        authorize(@story)

        result = Story::UpdateService.new(@story, story_params).process

        if result[:errors].nil?
          render jsonapi: @story,
            include: [:image, user: [profile: [:avatar]]],
            fields: { profile: [:username, :avatar] },
            status: :accepted
        else
          render jsonapi_errors: { detail: result[:errors] }, status: :not_acceptable
        end
      end

      def destroy
        authorize(@story)
        @story.destroy
      end

      private

      def find_story
        @story = Story.find_by!(id: params[:id])
      end

      def story_params
        params.require(:story).permit(:body, :longitude, :latitude, :image)
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
