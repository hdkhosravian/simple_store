# frozen_string_literal: true

class SerializableAttachment < JSONAPI::Serializable::Resource
  type do
    if @object.fileable_type == 'Profile'
      'avatar'
    elsif @object.fileable_type == 'Product'
      'product'
    elsif @object.fileable_type == 'Variation'
      'variation'
    end
  end

  attribute :content_type

  attribute :file_name do
    File.basename(@object.file.path)
  end

  attribute :content_type do
    @object.file.content_type
  end
end
