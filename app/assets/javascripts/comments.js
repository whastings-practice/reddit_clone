(function($) {

  var commentForm = $('#new-comment-form'),
      replyButtons = $('.reply-comment-button'),
      parentIdInput = $('#parent_comment_id'),
      closeButton = $('#comment-close-button'),
      commentsList = $('#comments-list');

  replyButtons.on('click', function(event) {
    event.preventDefault();
    var button = $(this);
    var parentId = button.attr('data-comment-id');
    parentIdInput.val(parentId);
    commentForm.remove();
    button.after(commentForm);
    commentForm.show();
    closeButton.show();
  });

  commentsList.on('click', '#comment-close-button', function(event) {
    event.preventDefault();
    commentForm.remove();
    closeButton.hide();
    commentsList.after(commentForm);
    parentIdInput.val(0);
  });


})(jQuery);
