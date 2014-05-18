class LibraryWorker
  include Sidekiq::Worker

  def perform(url)
   
    @library = Library.new(url: url) 
    response = Typhoeus.get("#{@library.url}/adventures.json")
   
    if response.response_body == "" 
      redirect_to adventures_path
    end
    parsed_response = JSON.parse(response.response_body)

    #loop through the adventures
    parsed_response["adventures"].each do |adventure|
      #for each adventure, pull out the title, author, guid, pages.
      @title = adventure["title"]
      @author = adventure["author"]
      @guid = adventure["guid"]
      @pages = adventure["pages"]
      #create a new adventure and set the above as each param. Make sure to include foreign-key for library.
      @adventure = @library.adventures.new(title: @title, author: @author, guid: @guid)
      #loop through the pages with in each adventure
      @pages.each do |page|
        #for each page, pull out the name and text
        @name = page["name"]
        @text = page["text"]
        #create a new page and set the above as the param. Make sure to include foreign-key for adventure.
        @page = @adventure.pages.new(name: @name, text: @text)
      end
    end
    #save everything with bang to that error is thrown
    @library.save!
   
  end


end