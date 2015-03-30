class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :clients
  has_many :projects, through: :clients
  has_many :time_entries, through: :projects

  validates :date_format, presence: true
  validates :state, length: {is: 2, allow_blank: true, allow_nil: true}
  validates :time_zone, presence: true

  composed_of :date_format, mapping: %w(date_format key), allow_nil: true, converter: ->(key) { DateFormat.new key }

  has_paper_trail on: []

  def self.resource_parameters
    [:name, :company, :email, :time_zone, :date_format, :street, :city, :state, :zip]
  end
end
