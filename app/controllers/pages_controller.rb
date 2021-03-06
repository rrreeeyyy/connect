class PagesController < ApplicationController
  before_action :redirect_to_sign_in, unless: :user_signed_in?
  before_action :set_page_find_by_page_name, only: [:show, :edit, :history]
  before_action :set_page, only: [:update, :destroy]
  before_action :add_breadcrumb_to_pages_path

  # GET /pages
  def index
    @pages = Page.page(params[:page])
  end

  # GET /pages/:page_name
  # GET /pages/:page_name.json
  def show
    add_breadcrumb @page.title.html_safe, page_path(id: @page.page_name)
  end

  # GET /pages/new
  def new
    @page = Page.new
    add_breadcrumb t('.creating_page'), new_page_path
  end

  # GET /pages/:page_name/edit
  def edit
    add_breadcrumb @page.title.html_safe, page_path(id: @page.page_name)
    add_breadcrumb t('.editing_page'), edit_page_path(id: @page.page_name)
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to page_url(id: @page.page_name),
                      notice: t('.page_was_successfully_created') }
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
        format.html { redirect_to page_url(id: @page.page_name),
                      notice: t('.page_was_successfully_updated') }
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
    authorize! :destroy, @page
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end

  # GET /pages/:page_name/history
  def history
    add_breadcrumb @page.title.html_safe, page_path(id: @page.page_name)
    add_breadcrumb t('.history'), history_page_path(id: @page.page_name)
  end

  private

  def set_page_find_by_page_name
    @page = Page.find_by_page_name(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Page.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def page_params
    page = params.require(:page).permit(:raw_title, :raw_body, :page_name)
    page[:user_id] = current_user.id
    page
  end

  def add_breadcrumb_to_pages_path
    add_breadcrumb t('page_list'), pages_path
  end
end
