module Api
  module V1
    class LikesController < Api::V1::ApiController
      before_action :authenticate!
      before_action :find_story

      def create
        authorize(Story)
        @story.liked_by current_user
      end

      def destroy
        authorize(Story)
        @story.unliked_by current_user
      end

      private

      def find_story
        @story = Story.find_by!(id: params[:story_id])
      end
    end
  end
end
