class PagesController < ApplicationController
  before_filter :load_adventure

  def show
    @page = @adventure.pages.find(params[:id])

  end

  def create
    @page = @adventure.pages.create(page_params)
    redirect_to new_adventure_page_path
  end

  def new
    @page = @adventure.pages.new
    @pages = @adventure.pages
  end

  def destroy
    
  end

  def update

  end

  def index

  end

  private
    def page_params
      params.require(:page).permit(:name, :text, :adventure_id)
    end

    def load_adventure
      @adventure = Adventure.find(params[:adventure_id])
    end

end
