class User < ApplicationRecord
	attr_accessor :login
  #before_commit :set_user_image_props
	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  not_blank = 'No puede quedar en blanco'
  email_regexp = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
  validates :username, presence: {message: not_blank}, uniqueness: { case_sensitive: true, message: 'Usuario Ya existe' }, on: [:create]
  validates :username, presence: {message: not_blank}, on: [:update]
	validates :name, :birth_date, presence: { message: not_blank }
  validates :email, format: {with: email_regexp, message: 'Forma de Email inválida'}, uniqueness: { case_sensitive: true, message: 'Correo Ya existe' }, on: [:create]
  validates :email, format: {with: email_regexp, message: 'Forma de Email inválida'}, on: [:update]

   def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(
        ['lower(username) = :value OR lower(email) = :value',
         { value: login.downcase }]
      ).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  def set_user_image_props(image_params)
    cl_options = {
      folder: "/randomizes/profile/#{self.id}",
      public_id: "profile_user_#{self.id}",
      eager: [
        {:width => 400, :height => 300, :crop => :pad}, 
        {:width => 260, :height => 200, :crop => :crop, :gravity => :north}
      ]
    }
    cl_image_url = Cloudinary::Uploader.upload(image_params.tempfile.path, cl_options)['url']
    cl_image_url
  end

  private

  # Attempt to find a user by it's email. If a record is found, send new
  # password instructions to it. If not user is found, returns a new user
  # with an email not found error.
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(
        ['lower(username) = :value OR lower(email) = :value',
         { value: login.downcase }]
      ).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

end
