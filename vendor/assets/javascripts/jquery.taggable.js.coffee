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
      .on('keyup', @findTags)
      .on('keypress', @createTags)

  findTags: (ev) =>
    if ev.target.value is ''
      @inputField.parent().find('#suggestion').empty()
    else if ev.keyCode isnt @options.key
      setTimeout =>
        $.ajax
          type: 'GET'
          url: '/tags'
          dataType: 'json'
          data:
            q: ev.target.value
          success: (data) =>
            suggestionField = @inputField.parent().find('#suggestion')
            if suggestionField.length == 0
              ul = document.createElement 'ul'
              $(ul).attr 'id', 'suggestion'
              @inputField.parent().append ul
            result = data.result
            suggestionField.empty()
            for str in result
              suggestionField.append "<li class=\"res\" data-suggestion-name=\"#{str}\">#{str}</li>"
            suggestionField.find('li').on('click', @createTag)
          error: () =>
            @inputField.parent().find('#suggestion').empty()

      , 300

  createTags: (ev) =>
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

        li = "<li data-tag-name='#{value}' class='tag'><a href='#' class='add-tag-link'>#{value}</a><a href='#' class='remove'>x</a></li>"
        $('.tag_list').append li
        @inputField.val('')

      $('.remove')
        .on('click', @remove)

  createTag: (ev) =>
    li = $(ev.target)
    value = li.data('suggestion-name')
    if $.isEmptyObject $(@options.hiddenFieldName).val()
      tags = []
    else
      tags = $(@options.hiddenFieldName).val().split(',')
    tags.push value
    $(@options.hiddenFieldName).val(tags.join())

    li = "<li data-tag-name='#{value}' class='tag'><a href='#' class='add-tag-link'>#{value}</a><a href='#' class='remove'>x</a></li>"
    $('.tag_list').append li
    @inputField.val('')

    @inputField.parent().find('#suggestion').empty()

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
