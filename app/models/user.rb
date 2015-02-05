class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :clients
  has_many :projects, through: :clients
  has_many :time_entries, through: :projects

  def self.resource_parameters
    [:name, :company, :email, :street, :city, :state, :zip]
  end
end
