import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

import Chart from 'chart.js/auto'
import Chartkick from 'chartkick'
Chartkick.use(Chart)

window.Chart = Chart
window.Chartkick = Chartkick