class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_one :settings, dependent: :destroy

  after_create { create_settings }
  after_create :add_default_role

  scope :notifiable, -> { joins(:settings).where(settings: { notifiable: true }) }

  def full_name
    if first_name && last_name
      [first_name, last_name].join(' ')
    end
  end

  def add_default_role
    add_role(:user)
  end

end
