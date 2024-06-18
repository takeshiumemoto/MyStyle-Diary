import $ from 'jquery';
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from '@fullcalendar/list';
import interactionPlugin from '@fullcalendar/interaction';
import 'bootstrap';

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

                $.ajax({
                    type: 'GET',
                    url: '/events/new',
                    headers: {
                        'Accept': 'text/html'
                    },
                    success: function(res) {
                        $('.modal-body').html(res);
                        $('#event_start_time_1i').val(year);
                        $('#event_start_time_2i').val(month);
                        $('#event_start_time_3i').val(day);
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
