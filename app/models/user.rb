class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token

  before_save { self.email = email.downcase }
  before_create :create_activation_digest


  validates :name, presence: true, length: { maximum: 50, minimum: 6 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, 
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
  # uniqueness: { case_sensitive: false }, 唯一, 不区分大小写
  validates :password, length: { minimum: 6 }, allow_blank: true
  
  has_secure_password

  # 返回制定字符串的哈希摘要 
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # 返回一个随机令牌
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 为了持久会话, 在数据库中记住用户
  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(self.remember_token)
    # update_attribute, 这个方法会跳过验证
  end

  # 如果指定的令牌和摘要匹配, 则返回true
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # 忘记用户
  def forget
    update_attribute :remember_digest, nil
  end

  # 激活账户
  def activate
    update_attribute :activated, true
    update_attribute :activated_at, Time.zone.now
  end

  # 发送激活邮件
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private
    # 创建并赋值激活令牌和摘要
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
