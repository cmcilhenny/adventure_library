class Library < ActiveRecord::Base
  has_many :adventures, dependent: :destroy

  validates :url, uniqueness: true

end
