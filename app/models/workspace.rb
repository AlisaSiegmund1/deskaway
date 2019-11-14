class Workspace < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :workspace_details, dependent: :destroy
  has_many :utilities, through: :workspace_details
  validates :name, uniqueness: true, presence: true
  validates :general_description, presence: true
  validates :address, presence: true
  validates :capacity, presence: true
  validates :price_per_hour, presence: true
  validates :photo, presence: true
  mount_uploader :photo, PhotoUploader


  include PgSearch::Model
  pg_search_scope :search_workspaces,
    against: [:address],
    using: {
      tsearch: { prefix: true }
    }
end
