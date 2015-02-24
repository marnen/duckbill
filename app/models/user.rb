class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :clients
  has_many :projects, through: :clients
  has_many :time_entries, through: :projects

  validates :date_format, presence: true
  validates :time_zone, presence: true

  def self.resource_parameters
    [:name, :company, :email, :time_zone, :date_format, :street, :city, :state, :zip]
  end
end
