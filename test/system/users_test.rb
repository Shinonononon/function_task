require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'user registration and welcome email' do
    visit new_user_path

    fill_in 'Name', with: 'Test User'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    attach_file 'Profile image', Rails.root.join('path/to/your/image.jpg') # 画像をアップロードする場合
    click_on 'Create my account'

    # メールが送信されたことを確認
    open_email('test@example.com')
    assert_equal '登録完了', current_email.subject
    assert_includes current_email.body.to_s, 'Test User様'
    assert_includes current_email.body.to_s, 'ユーザ登録が完了しました。'
  end
end
