class LibrariesController < ApplicationController
  respond_to :json

  def index
    @libraries = Library.all

    respond_with(@libraries) do |format|
      format.html {render "index"}
      format.json {render json: {libraries: @libraries}, except: [:id, :created_at, :updated_at]}
      
    end
  end

  def create 
    #get the parameter for the library and create a record
    # @library = Library.new 
    LibraryWorker.perform_async(library_params[:url])
    #redirect to adventures index
    redirect_to adventures_path
  end 

 

  def library_params
    params.require(:library).permit(:url)
  end

end
