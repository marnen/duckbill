class Client < ActiveRecord::Base
  has_many :projects
  belongs_to :user

  has_paper_trail # TODO: disable automatic versioning; see https://github.com/airblade/paper_trail/issues/481

  validates :user_id, presence: true

  def self.resource_params
    [:name, :company, :email, :street, :city, :state, :zip]
  end
end
