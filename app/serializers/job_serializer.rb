class JobSerializer < ActiveModel::Serializer

	attributes :id, :user_id, :type, :name, :status
	
end