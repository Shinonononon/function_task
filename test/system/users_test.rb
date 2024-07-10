# spec/system/users_spec.rb
require 'rails_helper'

RSpec.describe 'User registration', type: :system do
  include ActiveJob::TestHelper

  it 'sends a welcome email after user registration' do
    visit new_user_path

    perform_enqueued_jobs do
      fill_in 'Name', with: 'Test User'
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      attach_file 'Profile image', Rails.root.join('path/to/your/image.jpg') # 画像をアップロードする場合
      click_on 'Create my account'

      open_email('test@example.com')
      expect(current_email.subject).to eq '登録完了'
      expect(current_email.body).to include 'Test User様'
      expect(current_email.body).to include 'ユーザ登録が完了しました。'
    end
  end
end
