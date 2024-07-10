# spec/mailers/user_mailer_spec.rb
require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe '#welcome_email' do
    let(:user) { FactoryBot.create(:user, email: 'test@example.com') } # FactoryBotを使ってユーザを作成する例

    it 'sends welcome email' do
      email = UserMailer.welcome_email(user).deliver_later(wait: 1.minutes)

      expect(ActionMailer::Base.deliveries.count).to eq(1) # メールが1通送信されたことを確認

      expect(email.to).to eq([user.email]) # メールの宛先が正しいことを確認
      expect(email.from).to eq(['admin@example.com']) # メールの送信元が正しいことを確認
      expect(email.subject).to eq('登録完了') # メールの件名が正しいことを確認

      expect(email.body.encoded).to include("#{user.name}様") # メールの本文に特定のテキストが含まれていることを確認
      expect(email.body.encoded).to include('ユーザ登録が完了しました。')
    end
  end
end
