class Genre < ApplicationRecord
    has_many :items
  enum is_active: {Availble: true, Invalid: false}
   validates :name, presence: true
end
