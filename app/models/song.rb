class Song < ApplicationRecord
  after_create_commit { broadcast_prepend_later_to 'songs' }
  after_update_commit { broadcast_replace_later_to 'songs' }
  after_destroy_commit { broadcast_remove_to 'songs' }
  validates :title, presence: true
end
