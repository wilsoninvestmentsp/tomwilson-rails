class UserSerializer < ActiveModel::Serializer

	attributes :id, :name, :email, :password, :role, :phone, :image, :description, :admin, :public, :remote_image_url, :sort, :team, :raw_team, :created_at, :updated_at

end