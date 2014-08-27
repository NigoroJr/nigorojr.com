class SkkdictEntriesController < ApplicationController
  before_filter :login_required, :except => [:index, :search]

  def index
    @skkdict_entries = SkkdictEntry.all.order("reading")
    p @skkdict_entries
  end

  def new
    @skkdict_entry = SkkdictEntry.new
  end

  def edit
    @skkdict_entry = SkkdictEntry.find(params[:id])
    # Convert delimiter "\0" to human-readable ";"
    @skkdict_entry.tags.gsub!("\0", ";")
  end

  def create
    # If "Search" button is clicked
    if params[:commit].downcase == "search"
      search
      return
    end

    if params[:skkdict_entry][:reading].empty? ||
      params[:skkdict_entry][:word].empty?
      flash[:error] = "Both reading and word must not be empty"
      redirect_to controller: "skkdict_entries", action: "index"
      return
    end

    @skkdict_entry = SkkdictEntry.new
    @skkdict_entry.reading = params[:skkdict_entry][:reading]
    @skkdict_entry.word = params[:skkdict_entry][:word]
    @skkdict_entry.posted_by = @logged_in_as.username
    tags = params[:skkdict_entry][:tags]
    @skkdict_entry.tags = replace_delimiter(tags)

    if @skkdict_entry.save
      redirect_to action: "index"
    else
      render "new"
    end
  end

  def update
    if params[:skkdict_entry][:reading].blank? ||
      params[:skkdict_entry][:word].blank?
      flash[:error] = "Both reading and word must not be empty"
      redirect_to controller: "skkdict_entries", action: "index"
      return
    end

    @skkdict_entry = SkkdictEntry.find(params[:id])
    @skkdict_entry.reading = params[:skkdict_entry][:reading]
    @skkdict_entry.word = params[:skkdict_entry][:word]
    @skkdict_entry.posted_by = @logged_in_as.username
    tags = params[:skkdict_entry][:tags]
    @skkdict_entry.tags = replace_delimiter(tags)

    if @skkdict_entry.save
      redirect_to action: "index"
    else
      render "edit"
    end
  end

  def destroy
    @skkdict_entry = SkkdictEntry.find(params[:id])
    @skkdict_entry.destroy

    render "index"
  end

  def search
    if params[:tags] == nil
      redirect_to action: "index"
      return
    end
    tags = params[:tags].split(";")

    queries = []
    tags.each do |tag|
      queries.append("tags LIKE '%#{tag}%'")
    end
    # tags LIKE %foo% AND tags LIKE %bar% AND ...
    @skkdict_entries = SkkdictEntry.where(queries.join(" AND ")).order(:reading)

    # Bypass application.html.erb
    render "output", :layout => false
  end

  private
  # Tags from the form is separated by ';' but use
  # '\0' when saving to database.
  def replace_delimiter(orig_tags)
    new_tags = orig_tags.gsub(";", "\0")
    return new_tags
  end
end
