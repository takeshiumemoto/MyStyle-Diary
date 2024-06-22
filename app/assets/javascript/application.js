//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require jquery
import 'bootstrap';
import $ from 'jquery';

window.jQuery = $;
window.$ = $;

$(document).ready(function() {
  // Ensure that Bootstrap's dropdowns work with jQuery
  $('.dropdown-toggle').dropdown();
});