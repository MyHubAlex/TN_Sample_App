# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $('form#edit-answer-' + answer_id).show("slow");

  $('.comment-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $('form#comment-answer-' + answer_id).show();


  $('.vote_up_answer-link').bind 'ajax:success', (e, data, status, xhr) ->
    vote = $.parseJSON(xhr.responseText);
    $('.rating-answer-' + vote.id).html('Rating: ' + vote.votes_count);
    $('#cancel_vote-' + vote.id + '.hidden').toggleClass('hidden').addClass('vote_cancel_answer-link');
  

  $('.vote_down_answer-link').bind 'ajax:success', (e, data, status, xhr) ->
    vote = $.parseJSON(xhr.responseText);
    $('.rating-answer-' + vote.id).html('Rating: ' + vote.votes_count);
    $('#cancel_vote-' + vote.id + '.hidden').toggleClass('hidden').addClass('vote_cancel_answer-link');
    

  $('.vote_cancel_answer-link').bind 'ajax:success', (e, data, status, xhr) ->
    vote = $.parseJSON(xhr.responseText);
    $('.rating-answer-' + vote.id).html('Rating: ' + vote.votes_count);
    $('#cancel_vote-' + vote.id + '.vote_cancel_answer-link').toggleClass('vote_cancel_answer-link').addClass('hidden');


$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
