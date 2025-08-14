class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def respond_with_error(message)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: error_turbo_stream(message)
      end
    end
  end

  def notification_turbo_stream(message)
    turbo_stream.append("notifications", partial: "shared/notification", locals: { message: message })
  end

  def model_error_turbo_stream(model)
    turbo_stream.append("notifications", partial: "shared/errors", locals: { model: model })
  end

  def model_created_turbo_stream(model)
    turbo_stream.append("notifications", partial: "shared/created", locals: { model: model })
  end

  def model_updated_turbo_stream(model)
    turbo_stream.append("notifications", partial: "shared/updated", locals: { model: model })
  end
end
