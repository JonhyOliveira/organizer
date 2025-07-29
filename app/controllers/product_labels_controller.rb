class ProductLabelsController < ApplicationController
  before_action :set_product_label, only: %i[ show edit update destroy ]

  # GET /product_labels or /product_labels.json
  def index
    @product_labels = ProductLabel.all
    params[:expand_product_label_info_link] = true
    params[:expand_product_label_actions] = true
    params[:expand_product_label_action_show] = true
  end

  # GET /product_labels/1 or /product_labels/1.json
  def show
    params[:expand_product_label] = true
    params[:expand_product_label_actions] = true
  end

  # GET /product_labels/new
  def new
    @product_label = ProductLabel.new
  end

  # GET /product_labels/1/edit
  def edit
  end

  # POST /product_labels or /product_labels.json
  def create
    @product_label = ProductLabel.new(product_label_params)

    respond_to do |format|
      if @product_label.save
        format.html { redirect_to @product_label, notice: "Product label was successfully created." }
        format.json { render :show, status: :created, location: @product_label }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product_label.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_labels/1 or /product_labels/1.json
  def update
    respond_to do |format|
      if @product_label.update(product_label_params)
        format.html { redirect_to @product_label, notice: "Product label was successfully updated." }
        format.json { render :show, status: :ok, location: @product_label }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product_label.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_labels/1 or /product_labels/1.json
  def destroy
    @product_label.destroy!

    respond_to do |format|
      format.html { redirect_to product_labels_path, status: :see_other, notice: "Product label was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_label
      @product_label = ProductLabel.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def product_label_params
      params.expect(product_label: [ :energy, :fats, :saturated_fats, :carbohydrates, :sugar_carbohydrates, :protein, :salt, :vitamins, :ingredients, :baseline_type, :baseline, :name, :weight, :volume ])
    end
end
