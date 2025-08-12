class ContentBlocksController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :find_document_and_content_block

  def sanitize
    @document.sanitize!

    if @document.content_blocks.none?
      @document.content_blocks.create!(type: ContentBlock::Span, sort_index: 0)
    end
  end

  def index
    sanitize

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("#{dom_id(@document)}_content_blocks",
          partial: "content_blocks/collection", locals: { document: @document })
      end

      format.html { render "index" }
    end
  end

  def show
  end

  def update
    @content_block.update!(update_params)
    replace = @content_block.type_previously_changed?
    puts "content_block", @content_block.inspect, @content_block.changes.inspect

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: replace ? turbo_stream.replace(dom_id(@content_block.becomes(ContentBlock)),
          partial: "content_block/content_block", locals: { content_block: @content_block }) : []
      end

      format.html { redirect_to @document.object, notice: "Content block updated" }
    end
  end

  def destroy
    content_block = @content_block.becomes(ContentBlock)

    if @document.remove_content_block(content_block)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.remove(dom_id(content_block))
        end
        format.html { redirect_to document.object, notice: "Content block deleted successfully." }
      end
    else
      respond_with_error "Failed to delete content block."
    end

    sanitize
  end

  def create
    unless params[:placement].present? && params[:placement].is_a?(String)
      return respond_with_error "No placement param passed. Can't create content block"
    end

    content_block = ContentBlock.includes(:document).find(params[:content_block_id])
    document = content_block.document
    new_content_block = document.content_blocks.build(type: ContentBlock::Span)

    document.add_content_block(new_content_block, content_block, placement: params[:placement])

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.after(dom_id(content_block.becomes(ContentBlock)),
          partial: "content_block/content_block",
          locals: { content_block: new_content_block })
      end
      format.html { redirect_to content_block.document.object, highlight_content_block: content_block.id }
    end
  end

  def downgrade
    content_block = ContentBlock.find(params[:content_block_id])
    content_block_base = content_block.becomes(ContentBlock)

    content_block.downgrade!

    respond_to do |format|
      format.turbo_stream do
        ts = content_block.destroyed? ? turbo_stream.remove(dom_id(content_block_base))
          : turbo_stream.replace(dom_id(content_block_base), partial: "content_block/content_block",
            locals: { content_block: content_block } )
      end

      format.html { redirect_to document.object, notice: "Content block downgraded." }
    end
  end

  private

  def find_document_and_content_block
    @document = Document.find_by(id: params[:document_id])

    @content_block ||= begin
      return unless params[:content_block_id]

      if @document.present?
        @document.content_blocks.find(params[:content_block_id])
      else
        ContentBlock.find(params[:content_block_id])
      end
    end
  end

  def update_params
    params.expect(content_block: [ :metadata, :type ])
  end
end
