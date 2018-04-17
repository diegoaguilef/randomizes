class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

	validates :name, presence: true, on: [:update]
	validates :age, numericality: true, on: [:update]
	validates :birth_date, presence: true, on: [:update]
	validates :cell_phone, numericality: true, on: [:update]

end
