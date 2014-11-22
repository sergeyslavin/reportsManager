class Template
  include Mongoid::Document
  field :title, type: String

  has_many :items, dependent: :delete
  has_many :reports, dependent: :delete

end
