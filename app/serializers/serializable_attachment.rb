# frozen_string_literal: true

class SerializableAttachment < JSONAPI::Serializable::Resource
  type 'attachment'

  attributes :title

  attribute :file_name do
    File.basename(@object.file.path)
  end
end
