class SearchesController < ApplicationController
  before_action :set_search, only: [:show, :edit, :update, :destroy]

  # GET /searches
  # GET /searches.json
  def index

  end

  # GET /searches/1
  # GET /searches/1.json
  def show
    @cal= Array.new

    if(params[:type]=='Calendar Name')
    @searchCal=params[:search]
    @queryCal=Calendar.where("name LIKE (?)", "%#{@searchCal}%")
    @queryCal.each do |cal|
      @cal<<cal.Calid
    end
    end
    if ((params[:type]=='Event Name'))
     redirect_to   :controller => "searches", :action=>"eventShow" , :search=>params[:search]
    end
    if(params[:type]=='Department')
      @searchDept=params[:search]
      @queryDept=Category.where("name LIKE (?)", "%#{@searchDept}%")
      @queryDept.each do |cal|
        @searchCalId=Calendar.find_all_by_category_id(cal.id)
        @searchCalId.each do |calId|
          @cal<<calId.Calid
        end

      end

    end

  end

  # GET /searches/new
  def eventShow
    @calAll=Calendar.all
    #@event=Array.new
    service=session[:service]
    @event = GCal4Ruby::Event.find(service,params[:search])
    #@calAll.each do |calA|
    #  cally=GCal4Ruby::Calendar.find(service,calA.name, {})
    #    if !cally.nil?
    #
    #       if !event.nil?
    #          @event<<event
    #       end
    #    end
    #  end
  end

  # GET /searches/1/edit
  def edit
  end

  # POST /searches
  # POST /searches.json
  def create

  end

  # PATCH/PUT /searches/1
  # PATCH/PUT /searches/1.json
  def update

  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params[:search]
    end
end
