class ContentBlocksController < ApplicationController
  include ActionView::RecordIdentifier

  def index
    @document = Document.includes(:content_blocks).find(params[:document_id])

    if @document.content_blocks.none?
      @document.content_blocks.create!(type: ContentBlock::Span, sort_index: 0)
    end
  end

  def show
  end

  def update
  end

  def destroy
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
        render turbo_stream: turbo_stream.after(dom_id(content_block),
          partial: "content_block/content_block",
          locals: { content_block: new_content_block })
      end
      format.html { redirect_to content_block.document.object, highligh_content_block: content_block.id }
    end
  end
end
