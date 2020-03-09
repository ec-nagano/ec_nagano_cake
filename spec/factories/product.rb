FactoryBot.define do
    factory :product do
        category
        name {"TestProduct"}
        content {"content"}
        price {1000}
        product_image {"app/assets/images/no_image.jpg"}
    end
end