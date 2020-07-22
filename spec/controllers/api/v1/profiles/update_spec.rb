# frozen_string_literal: true

RSpec.describe Api::V1::ProfilesController, type: :request do
  describe '#update' do
    context 'valid request' do
      it 'updates current_user profile' do
        # Require data
        singed_in_user = create(:user)

        attributes = {
          profile: FactoryBot.attributes_for(
            :profile_params,
            avatar: fixture_file_upload('test.jpg', 'image/jpg'),
          ),
        }

        # Request
        sign_in(singed_in_user)
        put api_v1_profile_url(singed_in_user.profile),
            headers: auth_header,
            params: attributes

        # Expects
        data    = json['data']
        profile = attributes[:profile]
        avatar  = json['included'][0]['attributes']

        expect(response.status).to eq(202)
        expect(data['type']).to eq 'profile'
        expect(data['id']).to eq singed_in_user.profile.id.to_s
        expect(data['attributes']['description']).to eq profile[:description]
        expect(data['attributes']['username']).to eq profile[:username]
        # expect(data['attributes']['accessibility']).to eq profile[:accessibility]
        expect(avatar['file_name']).to include('test.jpg')

        # Cleaning
        singed_in_user.profile.avatar.file.remove!
      end

      it 'without :avatar param' do
        # Require data
        singed_in_user = create(:user)
        create(:profile, user: singed_in_user)

        update_attributes = {
          profile: FactoryBot.attributes_for(:profile_params),
        }

        # Request
        sign_in(singed_in_user)
        put api_v1_profile_url(singed_in_user.profile),
            headers: auth_header,
            params: update_attributes

        # Expects
        data    = json['data']
        profile = update_attributes[:profile]
        avatar  = json['included'][0]['attributes']

        expect(response.status).to eq(202)
        expect(data['type']).to eq 'profile'
        expect(data['id']).to eq singed_in_user.profile.id.to_s
        expect(data['attributes']['description']).to eq profile[:description]
        expect(data['attributes']['username']).to eq profile[:username]
        # expect(data['attributes']['accessibility']).to eq profile[:accessibility]
        expect(avatar['file_name']).to include('test.jpg')

        # Cleaning
        singed_in_user.profile.avatar.file.remove!
      end
    end
    context 'invalid request' do
      it 'updates current_user profile' do
        # Require data
        profile = create(:profile)

        attributes = {
          profile: FactoryBot.attributes_for(
            :profile_params,
            avatar: fixture_file_upload('test.jpg', 'image/jpg'),
          ),
        }

        # Request
        put api_v1_profile_url(profile),
            params: attributes

        # Expects
        expect(response.code).to eq '401'
        expect(json['errors'][0]['detail']).to include(I18n.t('messages.http._401'))

        # Cleaning
        profile.avatar.file.remove!
      end

      it 'update other profiles' do
        # Require data
        singed_in_user = create(:user)
        other_profile  = create(:profile)

        attributes = {
          profile: FactoryBot.attributes_for(
            :profile_params,
            avatar: fixture_file_upload('test.jpg', 'image/jpg'),
          ),
        }

        # Request
        sign_in(singed_in_user)
        put api_v1_profile_url(other_profile),
            headers: auth_header,
            params: attributes

        # Expects
        expect(response.status).to eq(403)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._403'))
      end
    end
  end
end
