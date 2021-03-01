class InstrumentsController < ApplicationController
    layout "instrument"

    def index
        @instruments = Instrument.all.alphabetize
     end
          
    def new
        if params[:instrument_id] && @instrument = Instrument.find_by_id(params[:instrument_id])
            @enrollment = @instrument.enrollments.build
        else
            @instrument = Instrument.new
            @instrument.enrollments.build
        end
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
        params.require(:instrument).permit(:name, enrollments_attributes: [:student, :start_date, :level, :price, :duration])
    end   
        
end