class JassetSerializer < ActiveModel::Serializer

	attributes :id, :title, :description, :link_name, :link_uri, :image, :sort, :created_at, :updated_at

end