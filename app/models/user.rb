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
    cl_image_props = Cloudinary::Uploader.upload(image_params.tempfile.path, cl_options)
    cl_image_props.to_json
  end

  protected

  # Attempt to find a user by it's email. If a record is found, send new
  # password instructions to it. If not user is found, returns a new user
  # with an email not found error.
  def self.send_reset_password_instructions attributes = {}
    recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    recoverable.send_reset_password_instructions if recoverable.persisted?
    recoverable
  end

  def self.find_recoverable_or_initialize_with_errors required_attributes, attributes, error = :invalid
    (case_insensitive_keys || []).each {|k| attributes[k].try(:downcase!)}

    attributes = attributes.slice(*required_attributes)
    attributes.delete_if {|_key, value| value.blank?}

    if attributes.size == required_attributes.size
      if attributes.key?(:login)
        login = attributes.delete(:login)
        record = find_record(login)
      else
        record = where(attributes).first
      end
    end

    unless record
      record = new

      required_attributes.each do |key|
        value = attributes[key]
        record.send("#{key}=", value)
        record.errors.add(key, value.present? ? error : :blank)
      end
    end
    record
  end

  def self.find_record login
    where(["username = :value OR email = :value", {value: login}]).first
  end
end
