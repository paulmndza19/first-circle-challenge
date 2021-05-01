module Orders
  class ComputeTotal
    def self.call(line_items)
      return line_items.sum(&:total)
    end
  end
end