require 'rails_helper'

RSpec.feature "customers/registrations_controller", type: :system do
  describe 'customers/sessions' do
    context 'Confirm links' do
      it 'Sign up' do
        visit root_path
        click_link '会員登録はこちら'
        expect(page).to have_content '新規登録'
      end
      it 'Sing out' do
        @customer = create(:customer)
        visit new_customer_session_path
        fill_in 'customer_email', with: @customer.email
        fill_in 'customer_password', with: @customer.password
        click_button 'ログイン'
        click_link 'ログアウト'
        expect(page).to have_content 'ログイン'
      end
    end
    context 'Confirm functions' do
      it 'Sign up' do
        visit new_customer_registration_path
        fill_in 'customer[first_name]', with: 'テスト'
        fill_in 'customer[last_name]', with: '太郎'
        fill_in 'customer[first_name_kana]', with: 'テスト'
        fill_in 'customer[last_name_kana]', with: 'タロウ'
        fill_in 'customer[postcode]', with: '1638001'
        fill_in 'customer[address]', with: '東京都新宿区西新宿二丁目８番１号'
        fill_in 'customer[phone_number]', with: '0000000000'
        fill_in 'customer[email]', with: 'test@email'
        fill_in 'customer[password]', with: 'password'
        fill_in 'customer[password_confirmation]', with: 'password'
        click_button '新規登録'
        expect(page).to have_content 'テスト様'
      end
    end
  end

end