class Project < ActiveRecord::Base
  has_many :notes
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
end