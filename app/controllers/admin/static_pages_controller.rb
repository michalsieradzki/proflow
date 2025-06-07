class Admin::StaticPagesController < Admin::ApplicationController
  before_action :set_static_page, only: [:show, :edit, :update, :destroy]
  
  def index
    @static_pages = StaticPage.all.order(created_at: :desc)
    @users_count = User.count if params[:dashboard]
  end
  
  def show
  end
  
  def new
    @static_page = StaticPage.new
  end
  
  def create
    @static_page = StaticPage.new(static_page_params)
    
    if @static_page.save
      redirect_to admin_static_page_path(@static_page), notice: 'Static page was successfully created.'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @static_page.update(static_page_params)
      redirect_to admin_static_page_path(@static_page), notice: 'Static page was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @static_page.destroy
    redirect_to admin_static_pages_path, notice: 'Static page was successfully deleted.'
  end
  
  # Specjalna akcja dla dashboardu
  def dashboard
    @users_count = User.count
    @recent_users = User.order(created_at: :desc).limit(5)
    @static_pages_count = StaticPage.count
    @recent_pages = StaticPage.order(updated_at: :desc).limit(5)
  end
  
  private
  
  def set_static_page
    @static_page = StaticPage.find_by!(slug: params[:id]) || StaticPage.find(params[:id])
  end
  
  def static_page_params
    params.require(:static_page).permit(:title, :slug, :published, :content)
  end
end
