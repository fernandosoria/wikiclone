class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def create
    @wiki = Wiki.new(wiki_params)

    if @wiki.save
      redirect_to @wiki, notice: "Wiki sucessfully saved."
    else
      render :new, error: "There was an error saving your Wiki. Please try again."
    end
  end

  def update
    @wiki = Wiki.find(params[:id])

    if @wiki.update_attributes(wiki_params)
      redirect_to @wiki, notice: "Wiki sucessfully saved."
    else
      render :new, error: "There was an error saving your Wiki. Please try again."
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    name = @wiki.title

    if @wiki.destroy
      redirect_to wikis_path, notice: "\"#{name}\" sucessfully deleted."
    else
      redirect_to @wiki, error: "There was an error deleting your Wiki. Please try again."
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end
end
