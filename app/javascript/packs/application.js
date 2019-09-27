/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// [rails/webpacker install instructions]
// "In /packs/application.js, include this at the top of the file:"
// import "core-js/stable"; - doesn't work: https://github.com/rails/webpacker/issues/2305
import "regenerator-runtime/runtime";

console.log('Hello World from Webpacker');

import "./hello_react";

import Turbolinks from "turbolinks";
import ReactRailsUJS from "react_ujs";

// From https://github.com/reactjs/react-rails/issues/899...
// This needs to be in this particular order:
Turbolinks.start();
// Add Turbolinks to the global namespace
window.Turbolinks = Turbolinks;
// Remove previous (native) events, and add Turbolinks'
ReactRailsUJS.detectEvents();
// (Optional) Clean up global namespace
// delete window.Turbolinks;

// Support component names relative to this directory:
var componentRequireContext = require.context("components", true);
ReactRailsUJS.useContext(componentRequireContext);
