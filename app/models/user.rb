class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  
  has_many :events, dependent: :destroy
  has_attached_file :avatar, :default_url => "/system/users/avatars/blank_avatar.jpg",
                             :path => ":rails_root/public/system/users/:id/:style/:filename",
                             :url => "/system/users/:id/:style/:filename"
  validates_attachment_content_type :avatar, 
                                    :content_type => /^image\/(png|gif|jpeg)/
                                    
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  validates :name, presence: true, length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX , uniqueness: { case_sensitive: false }}
  
  validates :birth_date, presence: true
  
  validates :password, length: { minimum: 6 }, :if => lambda { new_record? || !password.nil? }
  validates :password_confirmation, presence: true, :if => lambda { new_record? || !password.nil?}
  validates :time_zone, presence: true
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :birth_date, :password, :password_confirmation, :avatar, :time_zone)
  end
  
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end