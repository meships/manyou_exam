class Label < ApplicationRecord
    has_many :labellings, dependent: :destroy
    has_many :tasks, throgh: :labellings
end
