class Task < ApplicationRecord
    belongs_to :user

    has_many :labellings, dependent: :destroy
    has_many :labels, throgh: :labellings
    
    validates :title,presence: true
    validates :content,presence: true

    enum status:{未着手: 1, 着手中: 2, 完了: 3}
    enum priority:{低: 1, 中: 2, 高: 3} 

    scope :search_title, -> (title) {where('title LIKE ?',"%#{title}%")}
    scope :search_status, -> (status) {where(status: status)}
 
    scope :default_order, -> { order(created_at: :DESC) }
    scope :sort_limit, -> {order(limit: :asc)}
    scope :sort_priority, -> { order(priority: :DESC) }

    # scope :search_status, ->(status) {
    #     return if status.blank?
    #     where(status: status) }
    # scope :search_title, ->(title) {
    #     return if title.blank?
    #     where('title LIKE ?',"%#{title}%") }
end
