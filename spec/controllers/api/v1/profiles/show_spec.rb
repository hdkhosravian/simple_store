# frozen_string_literal: true

RSpec.describe Api::V1::ProfilesController, type: :request do
  describe '#show' do
    context 'valid request' do
      it 'shows the user profile' do
        # Require data
        singed_in_user = create(:user)

        # Request
        sign_in(singed_in_user)
        get api_v1_profile_url(singed_in_user.profile),
            headers: auth_header

        # Expects
        expect(response.status).to eq(200)
        expect(json['data']['type']).to eq 'profile'
        expect(json['data']['id']).to eq singed_in_user.profile.id.to_s
      end
    end

    context 'invalid request' do
      it 'unauthorized access' do
        # Require data
        profile = create(:profile)

        # Request
        get api_v1_profile_url(profile)

        # Expects
        expect(response.status).to eq(401)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._401'))

        # Cleaning
        profile.avatar.file.remove!
      end
    end
  end
end
