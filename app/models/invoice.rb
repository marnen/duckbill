class Invoice < ActiveRecord::Base
  class << self
    def for_full_display
      with_project.joins { client_version.outer }.joins { user_version.outer }.joins { time_entries.outer }
    end

    def versioned_associations
      [:client, :project, :user]
    end

    def with_project
      joins { project_version.outer }
    end

    private

    def has_versioned(association, required: nil)
      belongs_to :"#{association}_version", class_name: 'PaperTrail::Version'
      validates :"#{association}_version_id", presence: true if required
    end
  end

  belongs_to :project
  has_one :client, through: :project
  has_one :user, through: :client
  has_many :time_entries
  versioned_associations.each {|association| has_versioned association, required: true }

  validates :project_id, presence: true

  def capture_association_versions!
    transaction do
      self.class.versioned_associations.each do |association|
        record = self.send association
        if association == :user && !record # workaround for https://github.com/rails/rails/issues/16313
          record = client.user
        end
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
