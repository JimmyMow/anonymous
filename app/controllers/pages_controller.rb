class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy, :add_tag_list, :vote]

  # GET /pages
  # GET /pages.json
  def index
    if params[:search]
      @pages = Page.where("person LIKE ? OR person_id LIKE ?",
                                    "%#{params[:search]}%",
                                    "%#{params[:search]}%")
    elsif params[:tag]
      @pages = Page.tagged_with(params[:tag]).limit(25)
    end

    if current_user.gender == 'male'
      @randoms = Page.two_random_female
    else
      @randoms = Page.two_random_male
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @graph = Koala::Facebook::GraphAPI.new(current_user.oauth_token)
    @photos = @graph.get_connection(@page.person_id, 'photos')
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render action: 'show', status: :created, location: @page }
      else
        format.html { render action: 'new' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end

  def add_tag_list
    @page.tag_list.add(params[:tag_list])
    @page.save
    redirect_to page_url(@page.id)
  end

  def vote
    current_user.vote_for(@page)
    redirect_to pages_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
        params.require(:page).permit(:person, :person_id, :tag_list)
    end
end
