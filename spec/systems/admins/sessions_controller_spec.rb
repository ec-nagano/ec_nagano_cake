require 'rails_helper'

RSpec.feature "admin/sessions_controller", type: :system do
  before do
    @admin = create(:admin)
    visit new_admin_session_path
    fill_in 'admin_email', with: @admin.email
    fill_in 'admin_password', with: @admin.password
    click_button 'ログイン'
  end
  describe 'admin/sessions' do
    context 'Confirm functions' do
      it 'Sign in' do
        visit admin_path
        expect(page).to have_content '管理者画面'
      end
      it 'Sign out' do
        visit admin_path
        click_link 'ログアウト'
        expect(page).to have_content 'ログイン'
      end
    end
  end

end