# frozen_string_literal: true

class Profile
  class SetProfileAvatarService
    def initialize(profile, file)
      @profile = profile
      @file = file
    end

    def process
      if @profile.avatar
        Attachment::UpdateAttachmentService.new(@profile.avatar, @file).process
      else
        Attachment::CreateAttachmentService.new(@profile, @file).process
      end
    end
  end
end
