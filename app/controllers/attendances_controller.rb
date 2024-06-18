class AttendancesController < ApplicationController
  def time_in
    @attendance = current_student.attendances.new(time_in: Time.now, purpose: params[:purpose])
    if @attendance.save
      redirect_to root_path, notice: 'Time In recorded successfully.'
    else
      flash.now[:alert] = 'Failed to record Time In.'
      render 'students/new_time_in'
    end
  end

  def time_out
    @attendance = current_student.attendances.last
    @attendance.update(time_out: Time.now, purpose: params[:purpose])
    if @attendance.save
      redirect_to root_path, notice: 'Time Out recorded successfully.'
    else
      flash.now[:alert] = 'Failed to record Time Out.'
      render 'students/new_time_out'
    end
  end


end
