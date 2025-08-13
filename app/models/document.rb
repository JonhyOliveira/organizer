class Document < ApplicationRecord
  validates_presence_of :title

  def name
    self.title
  end
end
