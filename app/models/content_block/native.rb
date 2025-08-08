class ContentBlock::Native < ContentBlock
  def text_content
    metadata || ""
  end
end
