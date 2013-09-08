$(document).ready ->
  input = $ '[data-js=navigation]'
  path_regex = /\/intro\/(.*)/
  input.val path_regex.exec(window.location.pathname)[1]
  input.change ->
    window.location.pathname = "/intro/#{input.val()}"

