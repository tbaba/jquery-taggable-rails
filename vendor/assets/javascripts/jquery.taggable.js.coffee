$.taggable = (options = {}) ->
  new Taggable(options)

class Taggable
  constructor: (options) ->
    defaultOptions =
      key: 13
      inputFieldName: '#taggable'
      hiddenFieldName: '#tag_list'
      tagName: '.tag'

    @options = $.extend defaultOptions, options
    @inputField = $(@options.inputFieldName)

    @add()

  add: =>
    @inputField
      .on('keypress', @tagging)

  tagging: (ev) =>
    if ev.keyCode is @options.key
      ev.preventDefault()
      value = ev.target.value
      if value isnt ''
        if $.isEmptyObject $(@options.hiddenFieldName).val()
          tags = []
        else
          tags = $(@options.hiddenFieldName).val().split(',')
        tags.push value
        $(@options.hiddenFieldName).val(tags.join())

        li = "<li data-tag-name='#{value}' class='tag'>#{value}<a href='#' class='remove'>x</a></li>"
        $('.tag_list').append li
        @inputField.val('')

      $('.remove')
        .on('click', @remove)

  remove: (ev) =>
    ev.preventDefault()
    value = $(ev.target).parent().data 'tag-name'

    tags = $(@options.hiddenFieldName).val()
    tags = tags.split(',')
    tags = $.map tags, (n, i) ->
      if n isnt value
        n
      else
        null
    $(@options.hiddenFieldName).val(tags.join())

    $(ev.target).parent().remove()

$ ->
  $.taggable
    inputFieldName: '.taggable'
