$(document).ready(function() {
	var toggleCheckbox = function() {
    $('div.invite-user-checkbox').on('click', function(e){
      $(this).toggleClass('added');
      var userId = $(this).data('user-id');
      if ($('input[type="checkbox"]#' + userId).checked) {
        $('input[type="checkbox"]#' + userId).prop('checked', false);
      } else {
        $('input[type="checkbox"]#' + userId).prop('checked', true);
      }
    });
	}

  toggleCheckbox();

  $('input#goal_start_date').pickadate();

  $(document).on('click', 'div.recommend-more.strangers a', function(e) {
    e.preventDefault();
    toggleCheckbox();

    var data = {
      page: $(this).data('page'),
      user_ids: $(this).data('user-ids')
    };

    $.get('/show_more_strangers', data, function(response) {
      $('div.recommend-more.strangers').remove();
      $('div.invite-strangers').append(response['html']);

      toggleCheckbox();
    });
  });
});
