class Student < ApplicationRecord
	has_many :attendances, dependent: :destroy
end
