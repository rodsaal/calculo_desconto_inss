class InssController < ApplicationController
    def calculate
      salary = params[:salary].to_f
      discount = InssCalculatorService.new(salary).calculate
      render json: { discount: discount.round(2) }
    end
  end
  