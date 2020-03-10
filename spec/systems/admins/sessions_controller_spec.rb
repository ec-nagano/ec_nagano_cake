require 'rails_helper'

RSpec.feature "admin/sessions_controller", type: :system do
  describe 'admin/sessions#new' do
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: 'ec_nagano_cake@email'
      fill_in 'admin[password]', with: 'password'
      click_button 'ログイン'
    end
    context 'Confirm Sign In' do
      it 'Sign In' do
        visit admin_path
        expect(page).to have_content '管理者画面'
      end
    end
  end

end