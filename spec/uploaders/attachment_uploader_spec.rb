# frozen_string_literal: true

describe AttachmentUploader do
  let(:attachment) { create(:attachment) }

  let(:uploader) { AttachmentUploader.new(attachment, :file) }

  before do
    AttachmentUploader.enable_processing = true
    File.open(File.join(Rails.root, '/spec/fixtures/test.jpeg')) { |f| uploader.store!(f) }
  end

  after do
    AttachmentUploader.enable_processing = false
    uploader.remove!
  end

  it 'has the correct format' do
    # Expects
    expect(uploader.filename.split('.').last).to eql('jpeg')
  end

  it 'has the correct name' do
    # Expects
    expect(uploader.filename).to eql('test.jpeg')
  end
end
