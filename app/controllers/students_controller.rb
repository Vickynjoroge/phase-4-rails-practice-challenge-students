class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_response
    # GET/students
    def index
        students = Student.all
        render json: students
    end

    # GET/students/:id
    def show
        student = Student.find_by(id: params[:id])
        if student
            render json: student
        else
        render json: {error: "Student not found"}, status: :not_found
        end        
    end

    # POST /student
    def create
        student = Student.create!(student_params)
        render json: student_params, status: :created
    end

    #  PATCH/instructor/:id
    def update
        student = Student.find_by(id: params[:id])
        if Student
            student.update(student_params)
            render json: student
        else
            render json: {error: "Student not found"}, status: :not_found
        end
    end

     # DELETE/instructor/:id
    def destroy
        student = Student.find_by(id: params[:id])
        if student
            student.destroy
            head :no_content
        else
            render json: {error: "Student not found"}, status: :not_found
        end
    end
end

  private

    def student_params
      params.permit(:name, :age, :major, :instructor_id)
    end

        def render_record_invalid_response(invalid)
            render json: {error: invalid.record.errors.full_messages }, status: :unprocessable_entity
        end 
