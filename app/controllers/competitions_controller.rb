class CompetitionsController < ApplicationController
  # GET /competitions
  # GET /competitions.json
  def index
    @competitions = Competition.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @competitions }
    end
  end

  def generate_graph
    competition = Competition.find(params[:id])
    competition.generate_graph
    respond_to do |format|
      unless competition.graph_url.nil?
        format.html { redirect_to :back, :notice => "Graph generated successfully." }
      else
        flash[:error] = "Graph generation failed - double-check your match data."
        format.html { redirect_to :back }
      end
    end
  end

  def results
    @competition = Competition.find(params[:id])
  end

  def entry
    @competition = Competition.find(params[:id])
  end

  def build_matches
    competition = Competition.find(params[:id])
    competition.build_matches
    respond_to do |format|
      format.html {redirect_to entry_competition_path(competition), :notice => "Successfully built matches."}
    end
  end

  # GET /competitions/1
  # GET /competitions/1.json
  def show
    @competition = Competition.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @competition }
    end
  end

  # GET /competitions/new
  # GET /competitions/new.json
  def new
    @competition = Competition.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @competition }
    end
  end

  # GET /competitions/1/edit
  def edit
    @competition = Competition.find(params[:id])
  end

  # POST /competitions
  # POST /competitions.json
  def create
    logger.debug(params)
    @competition = Competition.new(params[:competition])
    respond_to do |format|
      unless @competition.save
        format.js
      end
    end
  end

  # PUT /competitions/1
  # PUT /competitions/1.json
  def update
    @competition = Competition.find(params[:id])

    respond_to do |format|
      if @competition.update_attributes(params[:competition])
        format.html { redirect_to @competition, notice: 'Competition was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @competition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /competitions/1
  # DELETE /competitions/1.json
  def destroy
    @competition = Competition.find(params[:id])
    @competition.destroy

    respond_to do |format|
      format.html { redirect_to competitions_url }
      format.json { head :no_content }
    end
  end
end
