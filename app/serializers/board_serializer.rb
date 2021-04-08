class BoardSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :height, :width, :mines
end
  