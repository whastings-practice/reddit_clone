// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require chosen-jquery
//= require_tree .

(function($) {

  $(document).ready(function() {
    var commentForm = $('#new-comment-form'),
        replyButtons = $('.reply-comment-button'),
        parentIdInput = $('#parent_comment_id');

    replyButtons.on('click', function(event) {
      event.preventDefault();
      var button = $(this);
      var parentId = button.attr('data-comment-id');
      parentIdInput.val(parentId);
      commentForm.remove();
      button.after(commentForm);
      commentForm.show();
    });
  });


})(jQuery);
