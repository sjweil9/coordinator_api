class ApiExceptionSerializer < ActiveModel::Serializer
  attributes :status, :code, :messages
end
