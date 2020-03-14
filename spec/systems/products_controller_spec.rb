require 'rails_helper'

RSpec.feature "products_controller", type: :system do
  describe "products" do
    context 'Confirm Index' do
      it "Index" do
        visit products_path
        expect(page).to have_content "一覧"
      end
    end
  end

end
