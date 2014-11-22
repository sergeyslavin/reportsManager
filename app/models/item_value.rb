class ItemValue
  include Mongoid::Document
  field :value, type: String
  field :item_id, type: String

  embedded_in :template
end
