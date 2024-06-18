class StudentsController < ApplicationController
  def time_in_form
    render 'students/time_in'
  end

  def time_in
    usn = params[:usn]
    student = Student.find_by(usn: usn)
  
    if student.present?
      @attendance = student.attendances.new(time_in: Time.now, purpose: params[:purpose])
  
      if @attendance.save
        flash[:success] = 'Time In recorded successfully.'
      else
        flash[:alert] = 'Failed to record Time In.'
      end
    else
      flash[:alert] = 'Student not found with the provided USN.'
    end
  
    redirect_to root_path
  end
  

  def time_out_form
    render 'students/time_out'
  end

  def time_out
    usn = params[:usn]
    student = Student.find_by(usn: usn)

    if student.present?
      @attendance = student.attendances.last
      @attendance.update(time_out: Time.now, purpose: params[:purpose])
      if @attendance.save
        redirect_to root_path, notice: 'Time Out recorded successfully.'
      else
        flash.now[:alert] = 'Failed to record Time Out.'
        render 'students/time_out'
      end
    else
      flash.now[:alert] = 'Student not found with the provided USN.'
      render 'students/time_out'
    end
  end
end
