class InstrumentsController < ApplicationController
    def index
        @instruments = Instrument.all
      end
          
      def new
        @instrument = Instrument.new
        3.times{@instrument.lessons.build}
      end
        

end