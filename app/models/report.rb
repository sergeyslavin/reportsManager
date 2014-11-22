class Report
  include Mongoid::Document
  field :title, type: String

  belongs_to :template
  embeds_many :item_values
end
