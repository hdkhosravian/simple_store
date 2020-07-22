# frozen_string_literal: true

class Story
    class CreateService
      def initialize(current_user, params)
        @params = params
        @current_user = current_user
      end
  
      def process
        result = ::Story::ValidateImageTypeService.new(@params[:image]).process
  
        return result if result.present? && result[:errors].present?
  
        story = Story.new(
          body: @params[:body],
          latitude: @params[:latitude],
          longitude: @params[:longitude],
          user: @current_user
        )
  
        if story.save
          Attachment::CreateAttachmentService.new(story, @params[:image]).process
          render_result(true, story, nil)
        else
          render_result(false, nil, story.errors.messages)
        end
      end
  
    private
  
      def render_result(result, object, errors)
        { result: result, object: object, errors: errors }
      end


      def create_tags!
        tags = @story.body.downcase.scan(/#(\w+)/).flatten.uniq.join(', ')
        @story.update(tag_list: tags) unless tags.empty?
      end
    end
  end