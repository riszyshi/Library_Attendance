class AdminsController < ApplicationController
  before_action :require_admin, except: [:login, :authenticate]

  def dashboard
    Time.use_zone('Asia/Manila') do
    start_of_day = Time.zone.now.beginning_of_day
    end_of_day = Time.zone.now.end_of_day

    @students_in = Student.joins(:attendances).where(attendances: { time_in: start_of_day..end_of_day }).distinct
    @students_out = Student.joins(:attendances).where(attendances: { time_out: start_of_day..end_of_day }).distinct

    Rails.logger.debug("SQL Query for students_in: #{Student.joins(:attendances).where(attendances: { time_in: start_of_day..end_of_day }).distinct.to_sql}")
    Rails.logger.debug("SQL Query for students_out: #{Student.joins(:attendances).where(attendances: { time_out: start_of_day..end_of_day }).distinct.to_sql}")
  end
  end

  def time_in_history
    @time_in_records = Attendance.where.not(time_in: nil).order(time_in: :desc)
  end
  
  def time_out_history
    @time_out_records = Attendance.where.not(time_out: nil).order(time_out: :desc)
  end

  def new_student
    @student = Student.new
  end

  def create_student
    @student = Student.new(student_params)
    @student.usn = generate_unique_usn

    if @student.save
      redirect_to admins_dashboard_path
    else
      render :new_student
    end
  end

  def all_students
    @all_students = Student.all

    # Check if the search parameter is present
    if params[:search].present?
      # Perform case-insensitive search by name
      @all_students = @all_students.where('LOWER(name) LIKE ?', "%#{params[:search].downcase}%")
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def search_students
    @search_results = Student.where('LOWER(name) LIKE ?', "%#{params[:search].downcase}%").order(:name)

    respond_to do |format|
      format.js
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      redirect_to admins_all_students_path, notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  def delete_student
    student = Student.find(params[:id])
    student.destroy
    redirect_to admins_all_students_path, notice: 'Student was successfully deleted.'
  end

  def login
  end

  def authenticate
    if params[:username] == 'admin' && params[:password] == 'adminpassword'
      session[:admin_id] = 1
      redirect_to admins_dashboard_path, notice: 'Logged in successfully.'
    else
      flash.now[:alert] = 'Invalid username or password.'
      render :login, layout: false
    end
  end

  def logout
    session[:admin_id] = nil
    redirect_to root_path, notice: 'Logged out successfully.'
  end

  private

  def generate_unique_usn
    usn_candidate = nil
  
    loop do
      candidate = "2023#{rand(1_000_000).to_s.rjust(6, '0')}"
      unless Student.exists?(usn: candidate)
        usn_candidate = candidate
        break
      end
    end
  
    usn_candidate
  end
  

  def require_admin
    unless current_admin
      redirect_to root_path, alert: 'You must be logged in as an admin to access this page.'
    end
  end

  def current_admin
    @current_admin ||= Admin.find_by(id: session[:admin_id]) if session[:admin_id]
  end

  def student_params
    params.require(:student).permit(:usn, :name, :age, :address, :emergency_contact_name, :emergency_contact_number, :birthdate, :year, :course, :contact_number)
  end
end
