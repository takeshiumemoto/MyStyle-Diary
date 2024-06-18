
import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';
import 'channels';
import $ from 'jquery';
import 'packs/calendar'; // Assuming calendar.js is in packs

Rails.start();
Turbolinks.start();
ActiveStorage.start();
