class Role
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :name, type: String

  embedded_in :user
end
