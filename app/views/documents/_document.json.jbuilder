json.extract! document, :id, :link, :name, :preview_text, :description, :date, :created_at, :updated_at
json.url document_url(document, format: :json)
