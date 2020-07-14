class Person < ApplicationRecord
    validates :house_id, :name, presence: true 

    belongs_to :residence,
        class_name: :House,
        primary_key: :id,
        foreign_key: :house_id
end
