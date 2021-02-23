class EnrollmentsController < ApplicationController
  
     before_action :set_enrollment
      layout "enrollment"

  def index
      # binding.pry
    if params[:instrument_id] && @instrument = Instrument.find_by(id: params[:instrument_id])
      # @enrollments =Instrument.find(params[:instrument_id]).enrollments
      @enrollments = @instrument.enrollments
    else
      @enrollments = Enrollment.all
    # else
    #    @enrollments = current_user.enrollments
    end
  end

  
  def show
    # @enrollment = current_user.enrollments.find_by(id: params[:id])
  end

  def new
    if params[:instrument_id]
      @instrument = current_user.instruments.find_by(id: params[:enrollment_id])
      @enrollment = current_user.enrollments.build(instrument_id: params[:instrument_id])
    else
      @enrollment = current_user.enrollments.build
    end
  end

  def create
    # binding.pry
     @enrollment = current_user.enrollments.build(enrollment_params)
      if @enrollment.valid?
        @enrollment.save
        redirect_to enrollment_path(@enrollment)
        flash[:message]= "Success,Enrollment Added."
      else
        @enrollment = Instrument.find_by_id(params[:instrument_id]) if params[:instrument_id]
        render :new
    end
  end

  def edit
    if current_user != @enrollment.user
      redirect_to user_path(current_user)
      flash[:error]= "Not your Enrollment" 
    else
      # @enrollment = current_user.enrollments.find_by(id: params[:id])
    end
  end

  def update
    # @enrollment = current_user.enrollments.find_by(id: params[:id])
    @enrollment.update(enrollment_params)
    if @enrollment.valid?
      redirect_to enrollment_path
      flash[:message]= "Enrollment Updated!"
    else
      render :edit
    end
  end

  def order_by_date
    @enrollment.created_at
  end


  def destroy
    # @enrollment = current_user.enrollments.find_by(id: params[:id])
    @enrollment.destroy
    redirect_to enrollments_path
    flash[:message]= "Enrollment was successfully deleted"
  end

  private
      
  def enrollment_params
    params.require(:enrollment).permit(:student,:startdate, :level, :price, :duration, :user_id, :instrument_id, instrument_attributes: [:name])
  end

  def set_enrollment
    @enrollment = current_user.enrollments.find_by(id: params[:id])
  end

end