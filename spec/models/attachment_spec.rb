# frozen_string_literal: true

# == Schema Information
#
# Table name: attachments
#
#  id            :bigint           not null, primary key
#  file          :string
#  fileable_type :string
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  fileable_id   :bigint
#
# Indexes
#
#  index_attachments_on_fileable_type_and_fileable_id  (fileable_type,fileable_id)
#

require 'rails_helper'

RSpec.describe Attachment, type: :model do
  subject(:attachment) { create(:attachment) }

  context 'associations' do
    it { expect(attachment).to belong_to(:fileable).optional }
  end
end
