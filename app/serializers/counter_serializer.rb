class CounterSerializer < ActiveModel::Serializer
  attributes :id, :name, :value
end
