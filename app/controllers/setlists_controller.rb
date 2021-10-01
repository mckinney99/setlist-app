class SetlistsController < ApplicationController
  before_action :set_setlist, only: %i[ show edit update destroy ]

  # GET /setlists or /setlists.json
  def index
    @setlists = Setlist.all.order(created_at: :desc)
    @setlist = Setlist.new
    @song = Song.new
    @songs = Song.all
  end

  # GET /setlists/1 or /setlists/1.json
  def show
  end

  # GET /setlists/new
  def new
    @setlist = Setlist.new
  end

  # GET /setlists/1/edit
  def edit
    @songs = Song.all.order(created_at: :desc)
  end

  def add_songs
    format.turbo_stream { render turbo_stream: turbo_stream.replace(@setlist_songs, partial: 'posts/form', locals: { setlist_songs: @setlist_songs }) }
  end


  # POST /setlists or /setlists.json
  def create
    @setlist = Setlist.new(setlist_params)
    respond_to do |format|
      if params[:create_song] && @setlist.save
        format.html { redirect_to setlists_path, notice: "Setlist was successfully created." }
        format.json { render :show, status: :created, location: setlists_path }
      elsif params[:create_song]
        Setlist.find(@setlist.id).update(:songs_id => params[:songs_id])
        format.html { render :index }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@song, partial: 'posts/songs', locals: { song: @song }) }
      elsif @setlist.save
        format.html { redirect_to setlists_path, notice: "Setlist was successfully created." }
        format.json { render :show, status: :created, location: setlists_path }
      else
        format.html { render :index }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@setlist, partial: 'posts/form', locals: { setlist: @setlist }) }
        # I think we want to replace the song turbo_stream here as well - This should stop displaying the song index before a setlist is made
      end
    end
  end

  # PATCH/PUT /setlists/1 or /setlists/1.json
  def update
    binding.pry
    respond_to do |format|
      if @setlist.update(setlist_params)
        format.html { redirect_to @setlist, notice: "Setlist was successfully updated." }
        format.json { render :show, status: :ok, location: @setlist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @setlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /setlists/1 or /setlists/1.json
  def destroy
    @setlist.destroy
    respond_to do |format|
      format.html { redirect_to setlists_url, notice: "Setlist was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setlist
      @setlist = Setlist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def setlist_params
      params.require(:setlist).permit(:title, :songs_id)
    end
end
