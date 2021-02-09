class User < ApplicationRecord
  # => User.first
  # => User.all
  before_save {self.email = self.email.downcase} 
  #自分自身か変数を定義しているのかわからないからemailにはselfつける
  validates :name,  presence: true, 
                      length: {maximum: 50}
                      
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, 
                      length: {maximum: 255}, 
                      format: {with: VALID_EMAIL_REGEX},
                  uniqueness: true
  has_secure_password 
  validates :password, presence: true, length: {minimum: 6}
  
  #渡された文字列のハッシュ値を返す
  def User.digest(string) #三項演算子
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                              BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
