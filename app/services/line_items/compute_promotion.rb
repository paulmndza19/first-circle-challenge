module LineItems
  class ComputePromotion
    def self.call(product, line_item)
      promotion = product.promotion
      return if promotion.nil?

      promotion_rule = promotion.promotion_rule.constantize

      promotion_rule.call(promotion, line_item)
    end
  end
end
