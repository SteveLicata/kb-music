window.onload = function() {
  console.log("DOM loaded");


  // For LOGO:
  $(".flex-container").css("display", "flex");

  // set height onload && window resize
  $(window).on("resize", function () {
    var height = $(window).height();
    $(".mock-div").css('height', height);
    $('.flex-container').css('height', height);
  }).resize();


  // fade to reveal, then hide so that <a> links are clickable
  $(".mock-div").delay(500).animate({"opacity": "0"}, 3000, function() {
    $(".mock-div").hide();
  }); // end mock div reveal


  // nav
  $('.collapse').collapse()

  // button
  $().button('toggle')

  //add a carousel to the homepage
  $('.carousel').carousel('cycle');


};//end window onload
