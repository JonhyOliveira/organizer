require "application_system_test_case"

class ProductLabelsTest < ApplicationSystemTestCase
  setup do
    @product_label = product_labels(:one)
  end

  test "visiting the index" do
    visit product_labels_url
    assert_selector "h1", text: "Product labels"
  end

  test "should create product label" do
    visit product_labels_url
    click_on "New product label"

    fill_in "Baseline", with: @product_label.baseline
    fill_in "Baseline type", with: @product_label.baseline_type
    fill_in "Carbohydrates", with: @product_label.carbohydrates
    fill_in "Energy", with: @product_label.energy
    fill_in "Fats", with: @product_label.fats
    fill_in "Ingredients", with: @product_label.ingredients
    fill_in "Protein", with: @product_label.protein
    fill_in "Salt", with: @product_label.salt
    fill_in "Saturated fats", with: @product_label.saturated_fats
    fill_in "Sugar carbohydrates", with: @product_label.sugar_carbohydrates
    fill_in "Vitamins", with: @product_label.vitamins
    click_on "Create Product label"

    assert_text "Product label was successfully created"
    click_on "Back"
  end

  test "should update Product label" do
    visit product_label_url(@product_label)
    click_on "Edit this product label", match: :first

    fill_in "Baseline", with: @product_label.baseline
    fill_in "Baseline type", with: @product_label.baseline_type
    fill_in "Carbohydrates", with: @product_label.carbohydrates
    fill_in "Energy", with: @product_label.energy
    fill_in "Fats", with: @product_label.fats
    fill_in "Ingredients", with: @product_label.ingredients
    fill_in "Protein", with: @product_label.protein
    fill_in "Salt", with: @product_label.salt
    fill_in "Saturated fats", with: @product_label.saturated_fats
    fill_in "Sugar carbohydrates", with: @product_label.sugar_carbohydrates
    fill_in "Vitamins", with: @product_label.vitamins
    click_on "Update Product label"

    assert_text "Product label was successfully updated"
    click_on "Back"
  end

  test "should destroy Product label" do
    visit product_label_url(@product_label)
    accept_confirm { click_on "Destroy this product label", match: :first }

    assert_text "Product label was successfully destroyed"
  end
end
