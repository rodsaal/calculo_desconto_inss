class ProponentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_proponent, only: [:show, :edit, :update, :destroy]

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

  def show; end

  def edit; end

  def update
    if @proponent.update(proponent_params)
      calculate_inss_discount(@proponent)
      @proponent.save
      redirect_to @proponent, notice: 'Proponente atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @proponent.destroy
    redirect_to root_path, notice: 'Proponente removido com sucesso.'
  end

  private

  def set_proponent
    @proponent = Proponent.find(params[:id])
  end

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
