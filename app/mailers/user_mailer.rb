class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user #インスタンス変数にするとテキストに読み出せる
    mail to: user.email, subject: "Account activation"
    # => return: mail object (text/html)
    #   example: mail.deliver
  end
  
  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
