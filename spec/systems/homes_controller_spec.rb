require 'rails_helper'

RSpec.feature "homes_controller", type: :system do
  describe 'homes#top' do
    before do
      @category = build(:category)
      @product = build(:product, category: @category)
      visit root_path
    end
    context 'Confirm Links' do
      it 'Sign up' do
        click_link '会員登録はこちら'
        expect(page).to have_content 'Sign up'
      end
      it 'Product detail' do
        visit product_path(@product.id)
        expect(page).to have_content 'TestProduct'
      end
    end
  end
  
end