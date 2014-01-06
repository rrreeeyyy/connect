class PagesController < ApplicationController
  before_action :render_404, unless: :user_signed_in?
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  # GET /page
  # GET /page.json
  def index
    @pages = Page.all
  end

  # GET /page/1
  # GET /page/1.json
  def show
  end

  # GET /page/new
  def new
    @page = Page.new
  end

  # GET /page/1/edit
  def edit
  end

  # POST /page
  # POST /page.json
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

  # PATCH/PUT /page/1
  # PATCH/PUT /page/1.json
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

  # DELETE /page/1
  # DELETE /page/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Page.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def page_params
    params.require(:page).permit(:raw_title, :raw_body, :url)
  end
end