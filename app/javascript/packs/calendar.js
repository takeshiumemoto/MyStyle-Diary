import $ from 'jquery';
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from '@fullcalendar/list';
import interactionPlugin from '@fullcalendar/interaction';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
import flatpickr from 'flatpickr';  // flatpickrをインポート

$(document).on('turbolinks:load', function () {
    function clearCalendar() {
        $('#calendar').html('');
    }

    const calendarEl = document.getElementById('calendar');
    if (calendarEl) {
        const calendar = new Calendar(calendarEl, {
            plugins: [dayGridPlugin, listPlugin, interactionPlugin],
            initialView: 'dayGridMonth',
            locale: 'ja',
            events: {
                url: '/events.json',
                method: 'GET',
                failure: function() {
                    alert('イベントの取得中にエラーが発生しました。');
                }
            },
            windowResize: function () {
                if (window.innerWidth < 992) {
                    calendar.changeView('listMonth');
                } else {
                    calendar.changeView('dayGridMonth');
                }
            },
            dateClick: function(info) {
                const date = info.date;
                const year = date.getFullYear();
                const month = date.getMonth() + 1;
                const day = date.getDate();
                const formattedDate = `${year}-${String(month).padStart(2, '0')}-${String(day).padStart(2, '0')}T00:00`;  // クリックした日付をフォーマット

                $.ajax({
                    type: 'GET',
                    url: '/events/new',
                    headers: {
                        'Accept': 'text/html'
                    },
                    success: function(res) {
                        $('.modal-body').html(res);
                        flatpickr('.datetime-picker', {
                            enableTime: true,
                            dateFormat: 'Y-m-dTH:i',
                            defaultDate: formattedDate  // フォームの初期日付にセット
                        });
                        $('#modal').modal('show');
                    },
                    error: function() {
                        alert('エラーが発生しました。運営に問い合わせてください。');
                    }
                });
            }
        });
        calendar.render();
    }

    $(document).on('turbolinks:before-cache', clearCalendar);
});