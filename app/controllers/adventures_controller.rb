class AdventuresController < ApplicationController
  # before_filter :load_library


  def index
    @adventures = Adventure.all
  end

  def new
    @adventures = Adventure.new
  end

  def create 
    adventure = Adventure.new adventure_params
    adventure.Guid = SecureRandom.urlsafe_base64
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

    # def load_library
    #   @library = Library.find(params[:library_id])
    # end
end
