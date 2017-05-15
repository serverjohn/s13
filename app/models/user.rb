class User < ActiveRecord::Base
  attr_accessor :password
  before_save :prepare_password
  has_many :checkouts
  belongs_to :congregation

  validates_presence_of :username
  validates_uniqueness_of :username, :email, :allow_blank => true
  validates_format_of :username, :with => /\A[-\w\._@]+\z/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true
  validates_presence_of :active, :first_name, :last_name

  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :first_name, :scope => :last_name
  

  def name_last_first
    "#{last_name}, #{first_name}"
  end
  
  def name_first_last
    "#{first_name} #{last_name}"
  end

  # ROLES as a constant.
  ROLES = %w[admin tservant checkout]

  def role_symbols
    [role.to_sym]
  end
  
  # checks if role exists
  def role?(role)
    User::ROLES.include? role.to_s
  end

  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.matching_password?(pass)
  end

  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = Digest::SHA1.hexdigest([Time.now, rand].join)
      self.password_hash = encrypt_password(password)
    end
  end

  def encrypt_password(pass)
    Digest::SHA1.hexdigest([pass, password_salt].join)
  end
end
