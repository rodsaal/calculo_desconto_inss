import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["salary", "result"]

  calculate() {
    const salary = this.salaryTarget.value

    if (!salary || isNaN(salary)) {
      this.resultTarget.textContent = "R$ 0,00"
      return
    }

    fetch(`/inss_discount?salary=${salary}`)
      .then(response => response.json())
      .then(data => {
        const formatted = new Intl.NumberFormat("pt-BR", {
          style: "currency",
          currency: "BRL"
        }).format(data.discount)

        this.resultTarget.textContent = formatted
      })
      .catch(() => {
        this.resultTarget.textContent = "Erro no cálculo"
      })
  }
}
