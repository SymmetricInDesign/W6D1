class User < ApplicationRecord
    validates :email, presence: true
    validates :email, uniqueness: true

    has_many :submitted_urls,
        foreign_key: :submitter_id,
        class_name: :ShortenedUrl
end