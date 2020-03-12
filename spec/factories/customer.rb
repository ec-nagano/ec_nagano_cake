FactoryBot.define do
    factory :customer do
        sequence(:email) { "test@email"}
        sequence(:password) { "password" }
        sequence(:first_name) { "テスト"}
        sequence(:last_name) { "太郎" }
        sequence(:first_name_kana) { "テスト"}
        sequence(:last_name_kana) { "タロウ" }
        sequence(:postcode) { "0000000" }
        sequence(:address) { "東京都新宿区西新宿二丁目８番１号"}
        sequence(:phone_number) { "0000000000" }
    end
end