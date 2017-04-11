# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('.js-csv-upload').fileinput
    showPreview: true
    maxFileCount: 1
    browseClass: 'btn btn-info fileinput-browse-button'
    browseIcon: ''
    browseLabel: 'File input'
    allowedFileExtensions: ['jpg', 'jpeg', 'png', 'gif']
    msgValidationError: '''
      <span class="text-danger">
        <i class="fa fa-warning"></i>無効なファイルです。
      </span>
    '''
  $('.kv-fileinput-upload').hide()
  $('.fileinput-remove-button').hide()
