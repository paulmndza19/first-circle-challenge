require 'test_helper'

class ProductsPromotionTest < ActiveSupport::TestCase
  test "should not save promotion without name" do
    promotion = ProductsPromotion.new
    promotion.product = products(:atv)
    promotion.description = 'Get 3 for the price of 2'

    refute promotion.save
  end

  test "should save promotion without a product" do
    promotion = ProductsPromotion.new
    promotion.name = 'Buy 2 Get 1'

    refute promotion.save
  end

  test "should save promotion with name" do
    promotion = ProductsPromotion.new
    promotion.product = products(:atv)
    promotion.name = 'Buy 2 Get 1'

    assert promotion.save
  end

  test "should save promotion even without freebie product" do
    promotion = ProductsPromotion.new
    promotion.product = products(:atv)
    promotion.name = 'Buy 2 Get 1'

    assert promotion.save
  end
end
