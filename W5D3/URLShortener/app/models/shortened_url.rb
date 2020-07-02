require 'securerandom'

class ShortenedUrl < ApplicationRecord

    def self.random_code
        random_code = nil
        while random_code.nil? || self.exists?(short_url: random_code)
            random_code = SecureRandom.urlsafe_base64
        end
        random_code
    end

    def self.create_new(user, url)
        ShortenedUrl.create!(
            long_url: url,
            short_url: ShortenedUrl.random_code,
            user_id: user.id
        )
    end

    def num_clicks
        Visit.where(url_id: self.id).count
    end

    def num_uniques
        Visit.select(:user_id).where(url_id: self.id).distinct.count
    end

    def num_recent_uniques
        ten_mins_ago = Time.now - 10.minute ; now = Time.now
        Visit.select(:user_id).where(url_id: self.id, created_at: (ten_mins_ago..now)).distinct.count
    end

    validates :short_url, uniqueness: true
    validates :long_url, :user_id, presence: true


    belongs_to(:submitter, {
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User
    })

    has_many(:visits, {
        primary_key: :id,
        foreign_key: :url_id,
        class_name: :Visit
    })

    has_many :visitors, through: :visits, source: :visitor

end