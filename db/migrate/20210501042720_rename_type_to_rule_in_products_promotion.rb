class RenameTypeToRuleInProductsPromotion < ActiveRecord::Migration[5.1]
  def change
    rename_column :products_promotions, :type, :promotion_rule
  end
end
