module LineItems
  class BuildParams
    def self.call(line_item_attributes)
      line_items_array = convert_to_array_of_hash(line_item_attributes)

      grouped_line_item_params = group_line_item_params(line_items_array)

      build_line_item_params(grouped_line_item_params)
    end

    private

    def self.convert_to_array_of_hash(line_item_attributes)
      line_items_array = []

      line_item_attributes.each do |k, attributes|
        line_items_array << attributes.to_h
      end

      line_items_array
    end

    def self.group_line_item_params(line_items_array)
      line_items_array.group_by { |line_item| line_item[:product_id] }
    end

    def self.build_line_item_params(grouped_line_item_params)
      line_items = []

      grouped_line_item_params.each do |k, v|
        total_quantity = v.sum { |line_item| line_item[:quantity].to_i }
        line_items << { product_id: k, quantity: total_quantity }
      end

      line_items
    end
  end
end