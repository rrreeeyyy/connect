class User < ActiveRecord::Base
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Relations
  has_many :blogs
  has_many :pages

  # Validations
  validates :email, presence: true
  validates :username, uniqueness: true, format: { with: /\A[\w\-]+\z/ },
                       allow_blank: true

  # Callbacks
  after_save do
    self.update_column('username', "user-#{id}") unless username
  end

  # Instance methods
  def url
    # TODO: Create user page
    # [Settings.connect.url, username].join('/')
    [Settings.connect.url, username, 'blog'].join('/')
  end

  def at_username
    "@#{username}"
  end

  def admin?
    role == 'admin'
  end
end
