class PagesController < ApplicationController
  before_filter :load_adventure

  def show
    @page = @adventure.pages.find(params[:id])

  end

  def create
    @page = @adventure.pages.new(page_params)
  end

  private
    def page_params
      params.require(:page).permit(:name, :text, :adventure_id)
    end

    def load_adventure
      @adventure = Adventure.find(params[:adventure_id])
    end

end
