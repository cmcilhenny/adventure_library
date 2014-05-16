class Adventure < ActiveRecord::Base
  belongs_to :library
  has_many :pages
  #calling create_guid before save completes
  before_save :create_guid

  private
  #pulling out the code that sets the guid from the controller and putting into model so I can use in console.
    def create_guid
      if self.guid == nil
        self.guid = SecureRandom.urlsafe_base64
      end
    end
end
