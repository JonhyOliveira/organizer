class AttachmentsMailbox < ApplicationMailbox
  before_process :check_if_has_attachments

  def process
  end

  def check_if_has_attachments
    bounce_with "No attachments" unless mail.attachments.present?
  end
end
