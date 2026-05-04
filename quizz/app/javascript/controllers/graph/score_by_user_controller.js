import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js";
Chart.register(...registerables);

export default class extends Controller {
  static targets = ["canvas"];

  connect() {
    const formated_scores = this.format(JSON.parse(this.canvasTarget.dataset.scores));

    new Chart(this.canvasContext(), {
      type: 'bar',
      data: {
        labels: Object.keys(formated_scores) ?? [],
        datasets: [{
          label: this.canvasTarget.dataset.label,
          data: Object.values(formated_scores) ?? [],
          backgroundColor: [
            'rgba(255, 99, 132, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(255, 206, 86, 0.2)',
            'rgba(75, 192, 192, 0.2)',
            'rgba(153, 102, 255, 0.2)',
            'rgba(255, 159, 64, 0.2)'
          ],
          borderColor: [
            'rgba(255, 99, 132, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(255, 206, 86, 1)',
            'rgba(75, 192, 192, 1)',
            'rgba(153, 102, 255, 1)',
            'rgba(255, 159, 64, 1)'
          ],
          borderWidth: 1
        }]
      },
      options: {
        plugins: {
          legend: {
            display: true
          }
        },
        scales: {
          y: {
            beginAtZero: true,
            title: {
              text: this.canvasTarget.dataset.y_legend,
              display: true
            }
          },
          x: {
            title: {
              text: this.canvasTarget.dataset.x_legend,
              display: true
            }
          }
        }
      }
    });
  }

  canvasContext() { return this.canvasTarget.getContext('2d'); }

  format(scores) {
    return scores.reduce((acc, item) => {
      const key = item.point;
      acc[key] = (acc[key] || 0) + 1;
      return acc;
    }, {});
  }
}
