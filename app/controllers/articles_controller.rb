class ArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_community
  before_action :verify_access
  before_action :verify_member, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :verify_author, only: [:edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
    @article = @community.articles.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article = @community.articles.new(article_params)
    @article.user = current_user

    respond_to do |format|
      if @article.save
        format.html { redirect_to community_article_path(@community,@article), notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to community_article_path(@community.id, @article.id), notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to community_articles_path, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_community
    @community = Community.find(params[:community_id])
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

  def verify_member
    redirect_to @community, notice: "You're not allowed to do that." if !user_is_member?(@community)
  end

  def user_is_author?(article)
    if user_signed_in?
      return user_is_member?(@community) && (current_user.id == article.author_id || user_is_admin?(@community))
    else
      return false
    end
  end

  def verify_author
    redirect_to @community, notice: "You're not allowed to do that." if !user_is_author? @article
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:article, :title)
    end
end
