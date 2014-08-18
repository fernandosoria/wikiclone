class WikisController < ApplicationController
  def index
    @wikis = Wiki.visible_to(current_user)
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])

    if request.path != wiki_path(@wiki)
      redirect_to @wiki, status: :moved_permanently
    end
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @users = (current_user.blank? ? User.all : User.find(:all, :conditions => ["id != ?", current_user.id]))
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    authorize @wiki

    if @wiki.save
      redirect_to @wiki, notice: "Wiki sucessfully saved."
    else
      render :new, error: "There was an error saving your Wiki. Please try again."
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.slug = nil
    authorize @wiki

    if @wiki.update_attributes(wiki_params)
      redirect_to @wiki, notice: "Wiki sucessfully saved."
    else
      render :new, error: "There was an error saving your Wiki. Please try again."
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    name = @wiki.title
    authorize @wiki

    if @wiki.destroy
      redirect_to wikis_path, notice: "\"#{name}\" sucessfully deleted."
    else
      redirect_to @wiki, error: "There was an error deleting your Wiki. Please try again."
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :public, collaborator_ids:[])
  end
end
