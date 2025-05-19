class UpdateInssDiscountJob < ApplicationJob
  queue_as :default

  def perform
    Proponent.find_each do |proponent|
      new_discount = InssCalculatorService.new(proponent.salary).calculate
      proponent.update(inss_discount: new_discount)
    end
  end
end
