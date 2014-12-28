$(document).ready(function() {
  var toggleCheckbox = function() {
    $('div.invite-strangers').on('click', '.invite-user-checkbox', function(e) {
      $(this).toggleClass('added');
      var userId = $(this).data('user-id');
      var userCheckbox = $('input[type="checkbox"]#' + userId);
      userCheckbox.prop('checked', ($(this).hasClass('added'))? true: false);
    });
  };

  toggleCheckbox();

  $('input#goal_start_date').pickadate({
    min: new Date()
  });

  $(document).on('click', 'div.recommend-more.strangers a', function(e) {
    e.preventDefault();

    var data = {
      page: $(this).data('page'),
      user_ids: $(this).data('user-ids')
    };

    $.get('/show_more_strangers', data, function(response) {
      $('div.recommend-more.strangers').remove();
      $('div.invite-strangers').append(response.html);
    });
  });
});
