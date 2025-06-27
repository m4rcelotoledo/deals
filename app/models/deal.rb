# frozen_string_literal: true

class Deal < ApplicationRecord
  belongs_to :user

  validates :customer, :description, :closing_date_probability, :value,
            presence: true

  enum :status, { pending: 0, won: 1, lost: 2 }
end
