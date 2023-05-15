window.languageAutocomplete = ->
  return false if !$("[data-provide=typeahead]").length

  projectLanguages = $("[data-provide=typeahead]").data "source"

  $("[data-provide=typeahead]").typeahead
    name: $(this).attr "name"
    local: projectLanguages

JQuery.timeago.settings.allowFuture = true;

JQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("[rel=tooltip]").tooltip()

  $('#presents a:first').tap('show')

  $('#presents a').click (e) ->
    e.preventDefault()
    $(this).tab "show"

    languageAutocomplete()

  $(document).on 'ready page:load', ->
    Emojify.replace '.js-emoji'