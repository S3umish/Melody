class InstrumentsController < ApplicationController
    def index
        @instruments = Instrument.all
    end
          
    def new
        @instrument = Instrument.new
        3.times{@instrument.enrollments.build}
    end

    def create
        @instrument = current_user.instruments.build(instrument_params)
        if @instrument.save
          redirect_to instruments_path(@instrument)
        else
          render :new
        end
    end
        
    def show
        @instrument = current_user.instruments.find_by(id: params[:id])
    end
      
    def destroy
        @instrument.destroy
        redirect_to instruments_path
    end
      
    private
    def instrument_params
        params.require(:instrument).permit(:name, enrollments_attributes: [:student,:start_date, :level, :price, :duration])
    end   
        
end