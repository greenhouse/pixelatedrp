
  jQuery(document).ready(function () {
    var $tabContainer = jQuery(".marketplace-main-wrapper");
    function SHOW_HIDE(bool) {
      if (bool) {
          $tabContainer.show();
      } else {
          $tabContainer.hide();
          window.blur()
      }
    }
    SHOW_HIDE(false); // hide the tablet initial

    // Listens for NUI messages from Lua
    window.addEventListener('message', function (event) {
      var item = event.data;
      if (item.showtab) {
          SHOW_HIDE(true)
      } // lua requested show
      else if (item.hidetab) {
          SHOW_HIDE()
      } // lua requested hide
    });


    document.addEventListener('keyup', function (data) {
       if (data.which == 27) {
         SHOW_HIDE(); // hide ui
         $.post("http://tab/tablet-bus", JSON.stringify({
             hide: true
         })) // tell lua to unfocus
       }
     });

     // Tell lua the nui loaded
      $.post("http://tab/tablet-bus", JSON.stringify({
          load: true
      }))
   });
