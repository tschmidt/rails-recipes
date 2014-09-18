class Project < ActiveRecord::Base
  has_many :notes
  has_many :visitations
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
end