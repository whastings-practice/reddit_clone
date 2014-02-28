# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  parent_comment_id :integer
#  user_id           :integer          not null
#  link_id           :integer          not null
#  body              :text             not null
#  created_at        :datetime
#  updated_at        :datetime
#

class Comment < ActiveRecord::Base
  validates :user_id, :link_id, :body, presence: true

  belongs_to :user
  belongs_to :link

  belongs_to(
    :parent_comment,
    foreign_key: :parent_comment_id,
    class_name: "Comment"
  )

  has_many(
    :child_comments,
    foreign_key: :parent_comment_id,
    class_name: "Comment"
  )
end
