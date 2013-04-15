class Project < ActiveRecord::Base
  attr_accessible :description, :discipline, :research_centre, :supervisor, :title
  
  validates :description, :title, :discipline, :presence => true
end
