# == Schema Information
#
# Table name: nobels
#
#  yr          :integer
#  subject     :string
#  winner      :string

require_relative './sqlzoo.rb'

def physics_no_chemistry
  # In which years was the Physics prize awarded, but no Chemistry prize?
  execute(<<-SQL)
    SELECT yr
    FROM nobels
    GROUP BY 1
    HAVING SUM(CASE WHEN subject = 'Physics' THEN 1 ELSE 0 END) > 0
    AND SUM(CASE WHEN subject = 'Chemistry' THEN 1 ELSE 0 END) = 0

  SQL
end
