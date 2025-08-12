class ContentBlock::Span < ContentBlock::Native
  def downgrade!
    destroy!
  end
end
