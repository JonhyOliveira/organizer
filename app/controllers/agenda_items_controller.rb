class AgendaItemsController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_agenda_collection, only: %i[ list kaban ]
  before_action :set_agenda_item, only: %i[ show edit update destroy tracker document attributes ]
  around_action :set_locale, only: %i[ create update ]
  helper AgendaItemHelper

  def tracker
  end

  def track
    puts parms.inspect
  end

  # GET /agenda_items/1 or /agenda_items/1.json
  def show
  end

  def document
  end

  def attributes
  end

  # GET /agenda_items/new
  def new
    @agenda_item = AgendaItem.new
    @agenda_item.create_document! if @agenda_item.document.nil?
  end

  # GET /agenda_items/1/edit
  def edit
    render :show
  end

  # POST /agenda_items or /agenda_items.json
  def create
    if params[:document_title].present?
      @agenda_item = AgendaItem.new(document: Document.create!(title: params[:document_title]))
    else
      @agenda_item = AgendaItem.new(agenda_item_params)
    end

    respond_to do |format|
      if @agenda_item.save
        format.html { redirect_to @agenda_item, notice: "#{@agenda_item.class.name.underscore.humanize} was successfully created." }
        format.json { render :show, status: :created, location: @agenda_item }
      else
        format.turbo_stream { render status: :unprocessable_entity, turbo_stream: model_error_turbo_stream(@agenda_item) }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @agenda_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agenda_items/1 or /agenda_items/1.json
  def update
    respond_to do |format|
      if @agenda_item.update(agenda_item_params)
        format.turbo_stream { render turbo_stream: [
          model_updated_turbo_stream(@agenda_item),
          turbo_stream.update(dom_id(@agenda_item).concat("_status"), partial: "agenda_items/status_tag", locals: { agenda_item: @agenda_item })
        ] }
        format.html { redirect_to @agenda_item, notice: "Agenda item was successfully updated." }
        format.json { render :show, status: :ok, location: @agenda_item }
      else
        format.turbo_stream { render status: :unprocessable_entity, turbo_stream: model_error_turbo_stream(@agenda_item) }
        format.html { render :show, status: :unprocessable_entity, notice: "Agenda item could not be updated. " + @agenda_item.errors.full_messages.join(", ") }
        format.json { render json: @agenda_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agenda_items/1 or /agenda_items/1.json
  def destroy
    @agenda_item.destroy!

    respond_to do |format|
      format.html { redirect_to agenda_items_path, status: :see_other, notice: "Agenda item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agenda_item
      @agenda_item = AgendaItem.find(params.expect(:id))
    end

    def set_agenda_collection
      @agenda_items = AgendaItem.all
    end

    # Only allow a list of trusted parameters through.
    def agenda_item_params
      params.expect(agenda_item: [ :start_time, :end_time, :do_by_start, :do_by_end, :document_id ])
    end

    def timezone_params
      params.permit(agenda_item: [ :timezone ])
    end

    def set_locale
      Time.use_zone(timezone_params[:timezone]) do
        yield
      end
    end
end
