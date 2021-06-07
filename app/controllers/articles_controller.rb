class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %I[ index ]
  before_action :set_rulebooks, only: %i[ new edit create ]
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1 or /articles/1.json
  def show
    @comment = Comment.new
    @comments = @article.comments
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def comments_create
    comment = Comment.create(comment_params)
    article = Article.find(params[:article_id])
    redirect_to article_path(article)
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def set_rulebooks
      @rulebooks = Rulebook.all.map { |r| [r.title, r.id] }
    end  

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :description, :rulebook_id).merge(user_id: current_user.id)
    end

    def comment_params
      params.permit(:body, :article_id).merge(user_id: current_user.id)
    end  
end
