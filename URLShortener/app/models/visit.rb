class Visit < ApplicationRecord
    validates :shortened_url_id, presence: true
    validates :user_id, presence: true

    belongs_to :visitor,
        foreign_key: :user_id,
        class_name: :User

    belongs_to :visited_url,
        foreign_key: :shortened_url_id,
        class_name: :ShortenedUrl

    def self.record_visit!(user, shortened_url)
        Visit.create!(user_id: user.id, shortened_url_id: shortened_url.id)
    end
end