class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[twitter google_oauth2]

  validates :uid, presence: true, uniqueness: { scope: :provider }, if: -> { uid.present? }

  # Omniauth認証データを元にデータベースでユーザーを探す。
  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid)
  end

  # session["devise.user_attributes"]が存在する場合、それとparamsを組み合わせてUser.newする。
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  # ログイン時、Omniauthで認証したユーザーのパスワード入力を免除する。
  def password_required?
    # provider属性に値があれば、パスワード入力を免除。
    super && provider.blank?
  end

  # Edit時、Omniauthで認証したユーザーのパスワード入力を免除する。
  def update_with_password(params, *options)
    # encrypted_password属性が空の場合
    if encrypted_password.blank?
      # パスワード入力なしにデータ更新
      update_attributes(params, *options)
    end
  end
end
