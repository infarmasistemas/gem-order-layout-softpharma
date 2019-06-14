require 'minitest/autorun'
require 'gem-order-layout-softpharma'

def order_file
  "12222223333333333333344444444444455555555______________________________\n2111111111111112222233333333333344444555______________________________\n3111111111111222223333333333444_________________________________________________"
end

def return_file
  "122222233333333333333444444444444555555556666666677888888888888888888888888888888\n222222222222222333334444455888888888888888888888888888888\n3222222222222333334444455555888888888888888888888888888888"
end

class LayoutTrierTest < Minitest::Test

  def test_order_file_header_field
    order_hash = OrderLayoutSoftPharma.read_order(order_file)
    h = order_hash[:header]
    test = [
        h[:register_type].to_s.length == 1,
        h[:client_code].to_s.length == 6,
        h[:cnpj_client].to_s.length == 14,
        h[:order_number].to_s.length == 12,
        h[:order_date].to_s.length == 8,
        h[:reserved].to_s.length == 30
    ].uniq

    assert (test.length == 1 && test[0] == true)
  end

  def test_order_file_details
    order_hash = OrderLayoutSoftPharma.read_order(order_file)
    h = order_hash[:details][0]
    test = [
        h[:register_type].to_s.length == 1,
        h[:product_code].to_s.length == 14,
        h[:quantity].to_s.length == 05,
        h[:price].to_s.length == 12,
        h[:offer_code].to_s.length == 5,
        h[:offer_time].to_s.length == 3,
        h[:reserved].to_s.length == 30
    ].uniq

    assert (test.length == 1 && test[0] == true)
  end

  def test_order_file_trailer_field
    order_hash = OrderLayoutSoftPharma.read_order(order_file)
    h = order_hash[:trailer]
    test = [
        h[:register_type].to_s.length == 1,
        h[:order_number].to_s.length == 12,
        h[:number_of_items].to_s.length == 5,
        h[:number_of_units].to_s.length == 10,
        h[:order_number_complement].to_s.length == 3,
        h[:reserved].to_s.length == 49
    ].uniq

    assert (test.length == 1 && test[0] == true)
  end

  def test_return_file_header_field
    order_hash = OrderLayoutSoftPharma.read_return(return_file)
    h = order_hash[:header]
    test = [
        h[:register_type].to_s.length == 1,
        h[:client_code].to_s.length == 6,
        h[:cnpj_client].to_s.length == 14,
        h[:order_number].to_s.length == 12,
        h[:order_date].to_s.length == 8,
        h[:order_processing_hour].to_s.length == 8,
        h[:order_situation].to_s.length == 2,
        h[:reserved].to_s.length == 30
    ].uniq

    assert (test.length == 1 && test[0] == true)
  end

  def test_return_file_details
    order_hash = OrderLayoutSoftPharma.read_return(return_file)
    h = order_hash[:details][0]
    test = [
        h[:register_type].to_s.length == 1,
        h[:product_code].to_s.length == 14,
        h[:number_served].to_s.length == 5,
        h[:number_not_served].to_s.length == 5,
        h[:reason_description].to_s.length == 2,
        h[:reserved].to_s.length == 30
    ].uniq

    assert (test.length == 1 && test[0] == true)
  end

  def test_return_file_trailer_field
    order_hash = OrderLayoutSoftPharma.read_return(return_file)
    h = order_hash[:trailer]
    test = [
        h[:register_type].to_s.length == 1,
        h[:order_number].to_s.length == 12,
        h[:number_items].to_s.length == 5,
        h[:number_served_items].to_s.length == 5,
        h[:number_not_served_items].to_s.length == 5,
        h[:reserved].to_s.length == 30
    ].uniq

    assert (test.length == 1 && test[0] == true)
  end
end

