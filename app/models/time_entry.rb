class TimeEntry < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :project
  has_one :user, through: :project
  [:project_id, :date, :hours, :description].each {|field| validates field, presence: true }

  class << self
    def resource_params
      [:project_id, :date, :hours, :description, :notes]
    end

    def uninvoiced
      where invoice_id: nil
    end
  end
end