require 'action_view'
require 'action_view/helpers'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  COLORS = ['red', 'orange', 'yellow', 'green', 'blue', 'purple', 'grey', 'black']

  validates :birthdate, :name, :sex, presence: true
  validates :sex, inclusion: { in: ['M', 'F'] }
  validates :color, inclusion: { in: COLORS }

  def age
    date_of_birth = DateTime.parse(self.birthdate.to_s)
    year_of_birth = date_of_birth.year
    Date.today.year - year_of_birth
  end
end

# d = Date.parse('3rd Feb 2001')
#                              #=> #<Date: 2001-02-03 ...>
# d.year                       #=> 2001

## 
# 2.6 inclusion
# This helper validates that the attributes' values are included in a given set. In fact, this set can be any enumerable object.

# class Coffee < ApplicationRecord
#   validates :size, inclusion: { in: [small, medium, large],
#     message: "%{value} is not a valid size" }
# end
# The inclusion helper has an option :in that receives the set of values that will be accepted. The :in option has an alias called :within that you can use for the same purpose, if you'd like to. The previous example uses the :message option to show how you can include the attribute's value. For full options please see the message documentation.

# The default error message for this helper is "is not included in the list".