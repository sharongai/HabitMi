$(document).ready(function() {
  $('div.explanation-carousel a.icon-link').on('click', function(e) {
    e.preventDefault();
    $('div.icons div.columns').removeClass('active');
    $(this).closest('div.three.columns').addClass('active');
    $('div.explanations').removeClass('active');

    switch ($(this).attr('class')) {
      case 'icon-link our-mission':
        $('div.explanations.our-mission').addClass('active');
        break;
      case 'icon-link trending-goals':
        $('div.explanations.trending-goals').addClass('active');
        break;
      case 'icon-link how-to-habit-mi':
        $('div.explanations.how-to-habit-mi').addClass('active');
        break;
      case 'icon-link win-prizes':
        $('div.explanations.win-prizes').addClass('active');
        break;
    }
  });

  $('input#goal_search').on('keyup', function() {
    $.get('/search-goals', { goal_title: $(this).val() }, function(result) {
      $('div.goal-results-holder').html(result['html']);
    });
  });



});

