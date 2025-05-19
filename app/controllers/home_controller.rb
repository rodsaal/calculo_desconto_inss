class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @proponents = Proponent.order(created_at: :desc).page(params[:page]).per(5)

    @salary_distribution = {
      "Até R$ 1.412,00" => Proponent.where(salary: 0..1412.00).count,
      "R$ 1.412,01 a R$ 2.666,68" => Proponent.where(salary: 1412.01..2666.68).count,
      "R$ 2.666,69 a R$ 4.000,03" => Proponent.where(salary: 2666.69..4000.03).count,
      "R$ 4.000,04 a R$ 7.786,02" => Proponent.where(salary: 4000.04..7786.02).count
    }
  end
end
