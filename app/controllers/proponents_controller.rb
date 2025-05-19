class ProponentsController < ApplicationController
  before_action :authenticate_user!
  
    def new
      @proponent = Proponent.new
      @proponent.addresses.build
      @proponent.contacts.build
    end
  
    def create
      @proponent = Proponent.new(proponent_params)
      calculate_inss_discount(@proponent)
  
      if @proponent.save
        redirect_to @proponent, notice: 'Proponente criado com sucesso.'
      else
        render :new
      end
    end
  
    def show
      @proponent = Proponent.find(params[:id])
    end
  
    private
  
    def proponent_params
      params.require(:proponent).permit(
        :name, :document, :birthdate, :salary,
        addresses_attributes: [:id, :street, :number, :neighborhood, :city, :state, :zip_code, :_destroy],
        contacts_attributes: [:id, :contact_type, :value, :_destroy]
      )
    end
  
    def calculate_inss_discount(proponent)
      proponent.inss_discount = InssCalculatorService.new(proponent.salary).calculate
    end
  end
  