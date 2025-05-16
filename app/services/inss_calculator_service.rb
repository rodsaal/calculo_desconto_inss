class InssCalculatorService
    BRACKETS = [
      { max: 1045.00, rate: 0.075 },
      { max: 2089.60, rate: 0.09 },
      { max: 3134.40, rate: 0.12 },
      { max: 6101.06, rate: 0.14 }
    ]
  
    def initialize(salary)
      @salary = salary.to_f
    end
  
    def calculate
      return 0.0 if @salary <= 0
  
      total = 0.0
      previous_limit = 0.0
  
      BRACKETS.each do |bracket|
        break if @salary <= previous_limit
  
        upper_limit = [@salary, bracket[:max]].min
        portion = upper_limit - previous_limit
        total += portion * bracket[:rate]
        previous_limit = bracket[:max]
      end
  
      total.round(2)
    end
  end
  