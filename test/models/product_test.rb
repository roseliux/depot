require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "products attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(title: "Hello akdjfakldjf",
                          description: 'test',
                          image_url: 'xyz.jpg')
    product.price = -1
    assert product.invalid?

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title: "Hello asdfasdfasdfadsf",
                description: 'test',
                price: 1,
                image_url: image_url)
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid."
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid."
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(title: products(:ruby).title,
                          description: 'test',
                          price: 1,
                          image_url: 'img.png')
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')],
                 product.errors[:title]
  end

  test "check that the title is at least ten characters" do
    product = Product.new(title: '123456789',
                          description: 'test',
                          price: 1,
                          image_url: 'img.png')
    assert product.invalid?, "length is #{product.title.length} must be greater than or equal to 10."
    assert_equal ["10 characters is the minimum allowed."],
                 product.errors[:title]
  end

end
