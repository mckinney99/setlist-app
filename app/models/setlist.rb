class Setlist < ApplicationRecord
  after_create_commit { broadcast_prepend_later_to 'setlists' }
  after_update_commit { broadcast_replace_later_to 'setlists' }
  after_destroy_commit { broadcast_remove_to 'setlists' }
  has_many :songs
  validates :title, presence: true
end
