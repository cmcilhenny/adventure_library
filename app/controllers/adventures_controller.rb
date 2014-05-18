class AdventuresController < ApplicationController

  respond_to :json

  def index
    @library = Library.new
    @adventures = Adventure.all
    @local_adventures = Adventure.where(library_id: nil)
    @other_adventures = Adventure.where("library_id is NOT NULL")
    
    respond_with(@adventures) do |format|
      
      format.html {render "index"}
      format.json {render json: {adventures: @local_adventures}, except: :id, include: :pages}
    end
  end

  def new
    @adventure = Adventure.new
    @adventure.pages.build
  end

  def create 
    @adventure = Adventure.new adventure_params
    if has_start_page? == true
      @adventure.save
    end
    redirect_to new_adventure_page_path(@adventure)
  end

  def show
    @adventure = Adventure.find(params[:id])
  
  end

  private 
    def adventure_params
      params.require(:adventure).permit(:title, :author, :pages_attributes=>[:name, :text])
    end

end
