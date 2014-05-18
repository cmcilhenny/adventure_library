class LibrariesController < ApplicationController
  respond_to :json

  def index
    @libraries = Library.all

    respond_with(@libraries) do |format|
      format.html {render "index"}
      format.json {render json: {libraries: @libraries}.as_json}
    end
  end

  def create 
    #get the parameter for the library and create a record
    @library = Library.new library_params
    #check that the url provided starts with http or https
     # if @library.url.starts_with? 'http://', 'https://'
    #if it is included, use typoeus to get the library associated with the url
    response = Typhoeus.get("#{@library.url}/adventures.json")
      #end
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
    #redirect to adventures index
    redirect_to adventures_path
  end 

 

  def library_params
    params.require(:library).permit(:url)
  end

end
