# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Attachment::CreateAttachmentService do
  it 'file format valid ' do
    # Require data
    file   = fixture_file_upload('test_file.jpeg')
    result = Attachment::CreateAttachmentService.new(nil, file).process

    # Expects
    expect(result.file.to_s).to include('test_file.jpeg')
  end

  it 'file format invalid' do
    # Require data
    file   = fixture_file_upload('test_file.dsk')
    result = Attachment::CreateAttachmentService.new(nil, file).process

    # Expects
    expect(result.id).to eql(nil)
  end
end
