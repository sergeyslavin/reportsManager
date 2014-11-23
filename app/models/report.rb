class Report
  include Mongoid::Document
  field :title, type: String

  belongs_to :template
  embeds_many :item_values

  validates_presence_of :title

  def template_obj
    Template.find(self.template_id)
  end
end
