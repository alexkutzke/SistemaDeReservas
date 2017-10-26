class WelcomeController < ApplicationController
  def index
    @classrooms = Classroom.where(state: true)
    @event = Event.new
  end
end
