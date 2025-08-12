class ContentBlock::Native < ContentBlock
  def html_classes = []

  def text_content
    metadata || ""
  end

  private

  def apply_command
    if self.metadata&.starts_with? "# "
      self.type = ContentBlock::H1
      self.metadata = self.metadata.remove("# ")
    end

    self.type.inspect
  end
end
