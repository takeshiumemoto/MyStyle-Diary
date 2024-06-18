// Import necessary modules
import $ from 'jquery';
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from '@fullcalendar/list';

// Document ready
$(document).on('turbolinks:load', function () {
    // Clear calendar before initializing
    function clearCalendar() {
        $('#calendar').html('');
    }

    // Check if calendar element exists and initialize
    const calendarEl = document.getElementById('calendar');
    if (calendarEl) {
        const calendar = new Calendar(calendarEl, {
            plugins: [dayGridPlugin, listPlugin],
            initialView: 'dayGridMonth',
            locale: 'jp',
            events: '/events.json', // URL to fetch events
            windowResize: function () {
                if (window.innerWidth < 991.98) {
                    calendar.changeView('listMonth');
                } else {
                    calendar.changeView('dayGridMonth');
                }
            },
        });
        calendar.render();
    }

    // Turbolinks events
    $(document).on('turbolinks:before-cache', clearCalendar);
});
