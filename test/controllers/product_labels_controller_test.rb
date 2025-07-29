require "test_helper"

class ProductLabelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_label = product_labels(:one)
  end

  test "should get index" do
    get product_labels_url
    assert_response :success
  end

  test "should get new" do
    get new_product_label_url
    assert_response :success
  end

  test "should create product_label" do
    assert_difference("ProductLabel.count") do
      post product_labels_url, params: { product_label: { baseline: @product_label.baseline, baseline_type: @product_label.baseline_type, carbohydrates: @product_label.carbohydrates, energy: @product_label.energy, fats: @product_label.fats, ingredients: @product_label.ingredients, protein: @product_label.protein, salt: @product_label.salt, saturated_fats: @product_label.saturated_fats, sugar_carbohydrates: @product_label.sugar_carbohydrates, vitamins: @product_label.vitamins } }
    end

    assert_redirected_to product_label_url(ProductLabel.last)
  end

  test "should show product_label" do
    get product_label_url(@product_label)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_label_url(@product_label)
    assert_response :success
  end

  test "should update product_label" do
    patch product_label_url(@product_label), params: { product_label: { baseline: @product_label.baseline, baseline_type: @product_label.baseline_type, carbohydrates: @product_label.carbohydrates, energy: @product_label.energy, fats: @product_label.fats, ingredients: @product_label.ingredients, protein: @product_label.protein, salt: @product_label.salt, saturated_fats: @product_label.saturated_fats, sugar_carbohydrates: @product_label.sugar_carbohydrates, vitamins: @product_label.vitamins } }
    assert_redirected_to product_label_url(@product_label)
  end

  test "should destroy product_label" do
    assert_difference("ProductLabel.count", -1) do
      delete product_label_url(@product_label)
    end

    assert_redirected_to product_labels_url
  end
end
