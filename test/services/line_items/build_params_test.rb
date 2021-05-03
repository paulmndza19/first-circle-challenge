module LineItems
  class BuildParamsTest < ActiveSupport::TestCase
    setup do
      @atv = Product.find_by(sku: 'atv')
      @mbp = Product.find_by(sku: 'mbp')
      @ipd = Product.find_by(sku: 'ipd')

      @line_item_params = {
        '0': {
          'product_id': @atv.id,
          'quantity': '1'
        },
        '1': {
          'product_id': @atv.id,
          'quantity': '1'
        },
        '2': {
          'product_id': @ipd.id,
          'quantity': '2'
        },
        '3': {
          'product_id': @ipd.id,
          'quantity': '3'
        },
        '4': {
          'product_id': @mbp.id,
          'quantity': '2'
        },
      }
    end

    test 'groups params with similar product ids' do
      simplified_line_item_params = LineItems::BuildParams.call(@line_item_params)

      assert_equal 3, simplified_line_item_params.length

      atvs = simplified_line_item_params.find { |line_item| line_item[:product_id] == @atv.id }
      assert_equal 2, atvs[:quantity]

      ipds = simplified_line_item_params.find { |line_item| line_item[:product_id] == @ipd.id }
      assert_equal 5, ipds[:quantity]

      mbps = simplified_line_item_params.find { |line_item| line_item[:product_id] == @mbp.id }
      assert_equal 2, mbps[:quantity]
    end
  end
end