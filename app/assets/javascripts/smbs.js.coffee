# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#smb_state_id').parent().hide()
  $('#smb_state_prov').parent().hide()
  states = $('#smb_state_id').html()
  $('#smb_country_id').change ->
    country = $('#smb_country_id :selected').text()
    escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(states).filter("optgroup[label='#{escaped_country}']").html()
    if options
      $('#smb_state_id').html(options)
      $('#smb_state_prov').parent().hide()
      $('#smb_state_prov').val('')
      $('#smb_state_id').parent().show()
    else
      $('#smb_state_id').empty()
      $('#smb_state_id').parent().hide()
      $('#smb_state_prov').parent().show()
      
jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  cardsetup.setupForm()

cardsetup =
  setupForm: ->
    $('#card_info').submit ->
      $('input[type=submit]').attr('disabled', true)
      if $('#card_number').length
        cardsetup.processCard()
        false
      else
        true
  
  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
      name: $('#name_on_card').val()
      addressLine1: $('#address_line_1').val()
      addressLine2: $('#address_line_2').val()
      addressCountry: $('#address_country').val()
    Stripe.createToken(card, cardsetup.handleStripeResponse)
  
  handleStripeResponse: (status, response) ->
    if status == 200
      $('#smb_stripe_card_token').val(response.id)
      $('#card_info')[0].submit()
    else
      $('#stripe_error').text(response.error.message)
      $('input[type=submit]').attr('disabled', false)
