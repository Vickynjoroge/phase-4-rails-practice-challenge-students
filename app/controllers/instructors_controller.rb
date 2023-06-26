class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_response

    # GET/intructor
    def index
        instructors = Instructor.all
        render json: instructors
    end
# POST /instructor
    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor_params, status: :created
    end
# GET/instructor/:id
    def show
        instructor = Instructor.find_by(id: params[:id])
        if instructor
            render json: instructor, include: :students
        else
            render json: {error: "Instructor not found"}, status: :not_found
        end
    end

    # PATCH/instructor/:id
    def update
        instructor = Instructor.find_by(id: params[:id])
        if instructor
            instructor.update(instructor_params)
            render json: instructor
        else
            render json: {error: "Instructor not found"}, status: :not_found
        end
    end
# DELETE/instructor/:id
    def destroy
        instructor = Instructor.find_by(id: params[:id])
        if instructor
            instructor.destroy
            head :no_content
        else
            render json: {error: "Instructor not found"}, status: :not_found
        end
    end
end

private
def instructor_params
    params.permit(:name)
end

def render_record_invalid_response(invalid)
    render json: {error: invalid.record.errors.full_messages }, status: :unprocessable_entity
end 