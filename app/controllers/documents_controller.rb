class DocumentsController < ApplicationController
  before_action :set_document, only: %i[ show edit update destroy ]

  # GET /documents or /documents.json
  def index
    @documents = Document.all
  end

  # GET /documents/1 or /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # POST /documents or /documents.json
  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: "#{@document.class.name.underscore.humanize} was successfully created." }
        format.json { render :show, status: :created, location: @document }
      else
        format.turbo_stream { reder status: :unprocessable_entity, turbo_stream: model_error_turbo_stream(@document) }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1 or /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.turbo_stream { render turbo_stream: model_updated_turbo_stream(@document) }
        format.html { redirect_to @document, notice: "#{@document.class.name.underscore.humanize} was successfully updated." }
        format.json { render :show, status: :ok, location: @document }
      else
        format.turbo_stream { render status: :unprocessable_entity, turbo_stream: model_updated_turbo_stream(@document) }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @document.destroy!

    respond_to do |format|
      format.html { redirect_to documents_path, status: :see_other, notice: "Document was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def edit
    render :show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def document_params
      params.expect(document: [ :title, :description, :content, :content_html ])
    end

    def search_params
      params.expect(search: [ :text ])
    end
end
