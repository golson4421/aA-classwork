class Employee

    attr_reader :salary, :employees
    attr_writer :boss

    def initialize(name, title, salary, boss=nil)
        @name = name
        @title = title
        @salary = salary
        @boss = boss
        @employees = []
    end

    def bonus(multiplier)
        bonus = @salary * multiplier
    end

end

class Manager < Employee
    
    attr_reader :employees

    def initialize(name, title, salary, employees, boss=nil)
        super(name, title, salary, boss)
        @employees = employees
    end

    def bonus(multiplier)
        salaries = []
        queue = [self]
        until queue.empty?
            boss = queue.pop
            boss.employees.each do |employee|
                queue.unshift(employee)
                salaries.unshift(employee.salary)
            end
        end
        bonus = salaries.sum * multiplier
    end
    
end


shawna = Employee.new("Shawna", "TA", 12000)
david = Employee.new("David", "TA", 10000)
darren = Manager.new("Darren", "TA", 78000, [shawna, david])
shawna.boss = darren
david.boss = darren
ned = Manager.new("Ned", "Founder",	1000000, [darren])
darren.boss = ned


p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000