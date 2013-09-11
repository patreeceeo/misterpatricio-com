$(document).ready ->
  input = $ '[data-js=navigation]'
  arrow = $ '[data-js=navigation-arrow]'
  path_regex = /\/intro\/(.*)/
  input.val path_regex.exec(window.location.pathname)[1]
  input.change ->
    window.location.pathname = "/intro/#{input.val()}"
  arrow.click ->
    console.log 'clicked arrow'
    input.click()
    false




