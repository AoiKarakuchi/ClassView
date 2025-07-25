// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"

import "@popperjs/core"
import "bootstrap"

import "controllers"
// アップロードしたファイル名が表示されるようにした
document.addEventListener('turbo:load', () => {
  const fileInput = document.getElementById('csv_file');
  const fileNameSpan = document.getElementById('file-name');
  if (fileInput && fileNameSpan) {
    fileInput.addEventListener('change', (e) => {
      const file = e.target.files[0];
      if (file) {
        fileNameSpan.textContent = file.name;
      } else {
        fileNameSpan.textContent = '';
      }
    });
  }
});