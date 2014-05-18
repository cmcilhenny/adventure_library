class Adventure < ActiveRecord::Base
  belongs_to :library
  has_many :pages, dependent: :destroy
  #calling create_guid before save completes
  before_save :create_guid

  def has_start_page?
    if adventure.pages.where(name: ""
    end
  end

  private
  #pulling out the code that sets the guid from the controller and putting into model so I can use in console.
    def create_guid
      if self.guid == nil
        self.guid = SecureRandom.urlsafe_base64
      end
    end

   
end
