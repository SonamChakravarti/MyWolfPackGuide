class FlyersController < ApplicationController

  private

  def flyer_params
    params.require(:flyer).permit(:category_id, :flyer_name, :image)
  end




  public

  def new
    @flyer= Flyer.new
  end

  def create
    @flyer=Flyer.new(flyer_params)
    if(@flyer.save!)
      flash[:notice]="Flyer successfully added"
    else
      flash[:error]="Something went wrong, Flyer addition failed"
    end
    redirect_to    '/flyers/show'

  end

  def show
      @Catdisp=Category.all
      @flyerdisp=Flyer.all
  end


  def  edit
    @flyeredit=Flyer.find(params[:id])

  end

  def update

    @call=Flyer.find(params[:id])
    flash[:confirm]="Are you sure you want to edit this Flyer?"
    @call.flyer_name=params[:name]
    if(@call.save!)
      flash[:notice]="Flyer successfully edited"
    else
      flash[:error]="Something went wrong, Flyer edition failed"
    end
    redirect_to    '/flyers/show'


  end

  def delete
      Flyer.find(params[:id]).destroy
    flash[:success] = "Category deleted."
    redirect_to    '/flyers/show'

  end



end
