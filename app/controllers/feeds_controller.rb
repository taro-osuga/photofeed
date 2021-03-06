class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, {only: [:edit, :update]}
  
  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = Feed.all.order(created_at: :desc)
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
    @favorite = current_user.favorites.find_by(feed_id: @feed.id)
  end

  # GET /feeds/new
  def new
    if params[:back]
      @feed = Feed.new(feed_params)
    else
      @feed = Feed.new
    end
  end

  def confirm
    @feed = Feed.new(feed_params)
    @feed = current_user.feeds.build(feed_params)
    render :new if @feed.invalid?
  end

  # GET /feeds/1/edit
  def edit
  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed = Feed.new(feed_params)    
    @feed = current_user.feeds.build(feed_params)

    respond_to do |format|
      if @feed.save
        # ContactMailer.contact_mail(@feed).deliver  ##追記
        format.html { redirect_to @feed, notice: '更新されました' }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
  def set_feed
    @feed = Feed.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
  def feed_params
    params.require(:feed).permit(:image, :image_cache, :comment)
  end

  def ensure_correct_user
    if current_user.id != @feed.user.id
      flash[:notice] = "編集権限がありません"
      redirect_to feeds_path
    end
  end

end




