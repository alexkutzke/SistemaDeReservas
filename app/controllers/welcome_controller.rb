class WelcomeController < ApplicationController
  def index
    @classrooms = Classroom.where(state: true)
  end
end
