class AdventuresController < ApplicationController

  respond_to :json

  def index
    @library = Library.new

    # Get all adventures to split into 3 buckets
    @adventures = Adventure.all

    @broken_adventures = []
    @local_adventures = []
    @other_adventures = []

    @adventures.each do |adventure|
      # Make sure has start page, else put in broken bucket
      if !adventure.has_start_page?
        @broken_adventures.push(adventure)
      else
        # If has start page, look for library ID nil for local
        if adventure.library_id == nil
          @local_adventures.push(adventure)
        # Otherwise, put in other bucket
        else
          @other_adventures.push(adventure)
        end
      end
    end

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
