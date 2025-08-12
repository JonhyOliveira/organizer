class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def respond_with_error(message)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append(:notifications, partial: "shared/notification", locals: { message: message })
      end
    end
  end
end
