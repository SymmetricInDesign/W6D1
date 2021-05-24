require "securerandom"

class ShortenedUrl < ApplicationRecord
    validates :short_url, presence: true, uniqueness: true
    validates :long_url, presence: true
    validates :submitter_id, presence: true

    belongs_to :submitter,
        foreign_key: :submitter_id,
        class_name:  :User

    def self.random_code
        code = nil
        while true
            code = SecureRandom.urlsafe_base64(6)
            next if ShortenedUrl.exists?(short_url: code)
            return code
        end
    end

    def self.create_url(user, long_url)
        ShortenedUrl.create!(short_url: ShortenedUrl.random_code, long_url: long_url, submitter_id: user.id)
    end


end