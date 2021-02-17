class EnrollmentsController < ApplicationController

    def index
        # binding.pry
        if params[:instrument_id]
            @instrument = current_user.instruments.find_by(id: params[:instrument_id])
            @lessons =Instrument.find(params[:instrument_id]).enrollments
            @lessons = @instrument.enrollments
        else
            @lessons = current_user.enrollments
        end
    end

    def show

    end

end