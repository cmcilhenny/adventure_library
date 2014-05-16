class LibrariesController < ApplicationController
  respond_to :json

  def index
    @libraries = Library.all

    respond_with(@libraries) do |format|
      format.html {render "index"}
      format.json {render json: {libraries: @libraries}.as_json}
    end
  end

  def scrape_library
    response = Typhoeus.get('@library.url.json', params: {})
  end

  def create 
    #what kinds of checks should you perform before saving a library?
    @library = Library.new library_params
    redirect_to adventures_path
  end 



  private

  def library_params
    params.require(:library).permit(:url)
  end

end
