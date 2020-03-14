FactoryBot.define do
    factory :admin do
        sequence(:email) { "ec_nagano_cake@email.com"}
        sequence(:password) { "password" }
    end
end