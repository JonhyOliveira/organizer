class Document < ApplicationRecord
  def preview_text
    description
  end
end
