class Project < ActiveRecord::Base
    attr_accessible :title. :description
                    :discipline, :research_centre,
                    :supervisor

  # validates :description, :title, :discipline, :presence => true
end
