import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';
import 'channels';
import $ from 'jquery';
import 'packs/calendar'; // Assuming calendar.js is in packs
import 'bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';
import Popper from 'popper.js'; // 正しいPopper.jsをインポート
import flatpickr from 'flatpickr';
import 'flatpickr/dist/flatpickr.min.css';
window.$ = $;
window.jQuery = $;
window.Popper = Popper; // Popperをグローバルに設定


$(document).on('turbolinks:load', function() {
  $('.datetime-picker').flatpickr({
    enableTime: true,
    dateFormat: 'Y-m-d H:i',
  });
});


Rails.start();
Turbolinks.start();
ActiveStorage.start();


