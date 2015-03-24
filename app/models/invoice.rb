class Invoice < ActiveRecord::Base
  belongs_to :project
  has_one :client, through: :project
  has_one :user, through: :client
  has_many :time_entries
  belongs_to :project_version, class_name: 'PaperTrail::Version'
  belongs_to :client_version, class_name: 'PaperTrail::Version'

  [:client_version_id, :project_id, :project_version_id].each do |field|
    validates field, presence: true
  end

  def self.with_time_entries
    joins { time_entries.outer }.joins { project.client }
  end

  def capture_association_versions!
    transaction do
      version_ids = {}
      [:client, :project].each do |association|
        record = self.send(association)
        record.touch_with_version
        self[:"#{association}_version_id"] = record.versions.last.id
      end
    end
  end

  def snapshot(association)
    self.send("#{association}_version").reify
  end

  def number
    id
  end
end
