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
    @adventures = Adventure.new
  end

  def create 
    adventure = Adventure.new adventure_params
    
    adventure.save
    redirect_to adventure_path
  end

  def show
    @adventure = Adventure.find(params[:id])
  
  end

  private 
    def adventure_params
      params.require(:adventure).permit(:title, :author)
    end

end
