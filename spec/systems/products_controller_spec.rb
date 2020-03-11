require 'rails_helper'

RSpec.feature "products_controller", type: :system do
  describe "products" do
    context 'Confirm Index' do
      it "Index" do
        visit root_path
        click_link '商品一覧へ（ジャンル検索）'
        expect(page).to have_content "一覧"
      end
    end
  end

end
