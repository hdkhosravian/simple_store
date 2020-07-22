module Api
  module V1
    class CommentsController < Api::V1::ApiController
      before_action :authenticate!
      before_action :find_story
      before_action :find_comment, only: %i(show update destroy)

      def index
        authorize(Comment)
        @comments = @story,comments

        render jsonapi: @comments,
          include: [user: [profile: [:avatar]]],
          fields: { profile: [:username, :avatar] }
      end

      def show
        authorize(@comment)

        render jsonapi: @comment,
          include: [user: [profile: [:avatar]]],
          fields: { profile: [:username, :avatar] }
      end

      def create
        param! :comment, String, required: true, blank: false

        authorize(Comment)
        @comment = Comment.build_from( 
          @stroy, current_user.id, params[:comment]
        )

        if @comment.save
          render jsonapi: @comment,
            include: [user: [profile: [:avatar]]],
            fields: { profile: [:username, :avatar] },
            status: :created
        else
          render jsonapi_errors: { detail: @comment.errors }, status: :not_acceptable
        end
      end

      def update
        param! :comment, String, required: true, blank: false

        authorize(@comment)
        @comment.body = params[:body] if params[:body].present?

        if @comment.save
          render jsonapi: @comment,
            include: [user: [profile: [:avatar]]],
            fields: { profile: [:username, :avatar] },
            status: :accepted
        else
          render jsonapi_errors: { detail: @comment.errors }, status: :not_acceptable
        end
      end

      def destroy
        authorize(@comment)
        @story.destroy
      end

      private

      def find_story
        @story = Story.find_by!(id: params[:story_id])
      end

      def find_comment
        @comment = Comment.find_by!(id: params[:id])
      end
    end
  end
end