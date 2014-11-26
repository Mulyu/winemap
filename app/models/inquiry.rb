class Inquiry
  include ActiveModel::Model

  attr_accessor :name, :email, :message

  VALID_EMAIL_REGEX = /\A([\w+\-.]+@[a-z\d\-.]+\.[a-z]+)?\z/i

  validates :email,
    length: { maximum: 255, message: 'メールアドレスは255文字以内で入力してください' },
    format: { with: VALID_EMAIL_REGEX , message: 'メールアドレスが不正な値です' }
  validates :message,
    presence: { message: 'お問い合わせ内容を入力してください' }
end