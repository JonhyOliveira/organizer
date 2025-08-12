class ContentBlock::Header < ContentBlock::Native
  def downgrade!
    update!(type: ContentBlock::Span)
  end
end
