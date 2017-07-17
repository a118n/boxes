class Repair < ApplicationRecord
  belongs_to :device

  validates :status, :description, :ticket_id, presence: true

  enum status: [:Successful, :Failed, :"In Process"]
end
