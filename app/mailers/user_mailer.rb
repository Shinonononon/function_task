class UserMailer < ApplicationMailer
  default from: 'admin@example.com'

  def welcome_email(user)
    @user = user
    @name = params[:name]
    mail(to:  params[:to], subject: '登録完了')
  end
end

# def welcome
#   @name = params[:name] # params: 呼び出し元から渡されたデータ
#   # インスタンス変数に代入すると次のビューで使える
#   mail(to: params[:to], subject: "登録完了") # メール送信
# end
