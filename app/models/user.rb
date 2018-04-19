class User < ApplicationRecord
	attr_accessor :login
	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  	validate :validate_username
	validates :name, presence: true, on: [:update]
	validates :age, numericality: true, on: [:update]
	validates :birth_date, presence: true, on: [:update]
	validates :cell_phone, numericality: true, on: [:update]

	def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
    end

    def validate_username
  		if User.where(email: username).exists?
    		errors.add(:username, :invalid)
  		end
	end
end
