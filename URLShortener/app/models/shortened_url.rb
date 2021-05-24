require "securerandom"

class ShortenedUrl < ApplicationRecord
    validates :short_url, presence: true, uniqueness: true
    validates :long_url, presence: true
    validates :submitter_id, presence: true

    belongs_to :submitter,
        foreign_key: :submitter_id,
        class_name:  :User

    has_many :visits,
        foreign_key: :shortened_url_id,
        class_name: :Visit
    
    has_many :visitors,
        -> { distinct },
        through: :visits,
        source: :visitor

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

    def num_clicks
        self.visits.count
    end

    def num_uniques
        self.visitors.count
    end

    def num_recent_uniques
        self.visitors.where('visits.created_at > ?', 20.minutes.ago).count
    end


end