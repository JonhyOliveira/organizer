class ApplicationMailbox < ActionMailbox::Base
  routing /attachments-/i => :attachments
end
