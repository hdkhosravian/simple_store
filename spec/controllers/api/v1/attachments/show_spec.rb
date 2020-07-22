# frozen_string_literal: true

RSpec.describe Api::V1::AttachmentsController, type: :request do
  describe '#show' do
    context 'valid request' do
      it 'shows profile avatar' do
        # Require data
        singed_in_user = create(:user)
        attachment = create(:attachment, fileable: singed_in_user)

        # Request
        sign_in(singed_in_user)
        get api_v1_attachment_url(attachment),
            headers: { 'Authorization': "bearer #{token}" }

        # Expects
        expect(response.status).to eq(200)

        # Cleaning
        attachment.file.remove!
      end
    end
    context 'invalid request' do
      it 'unauthorized access' do
        # Require data
        profile = create(:profile)

        # Request
        get api_v1_attachment_url(profile)

        # Expects
        expect(response.status).to eq(401)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._401'))

        # Cleaning
        profile.avatar.file.remove!
      end
    end
  end
end
