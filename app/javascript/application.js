// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", function() {
  const calendarDays = document.querySelectorAll('.calendar-day');
  const startDateInput = document.querySelector('#reservation_start_date'); // 予約フォームの開始日フィールド

  calendarDays.forEach(day => {
    day.addEventListener('click', function(event) {
      event.preventDefault(); // リンクのデフォルト動作を無効化

      // data属性から日付を取得して、フォームに入力
      const date = day.getAttribute('data-date');
      startDateInput.value = date; // フォームの開始日を更新
    });
  });
});